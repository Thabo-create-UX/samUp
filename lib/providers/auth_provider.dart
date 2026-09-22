import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool isGuest = false;
  bool isLoading = false;
  String? authMessage;

  User? get currentUser => _supabase.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  /// Continue using the app without signing in.
  void continueAsGuest() {
    isGuest = true;
    authMessage = null;
    notifyListeners();
  }

  /// Register a new student.
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required String studentNumber,
    required String course,
    required int yearOfStudy,
    String? phone,
  }) async {
    isLoading = true;
    authMessage = null;
    notifyListeners();

    try {
      // Create the Supabase Auth account.
      final response = await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'full_name': fullName.trim(),
          'role': 'student',
          'phone': phone?.trim(),
        },
      );

      final user = response.user;

      if (user == null) {
        authMessage = 'Registration failed. Please try again.';
        return false;
      }

      /*
       * If email confirmation is enabled in Supabase,
       * there may not be a session yet.
       */
      if (response.session == null) {
        authMessage =
            'Account created. Please check your email and confirm your account before signing in.';
        return true;
      }

      // Create the student's profile.
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'full_name': fullName.trim(),
        'email': email.trim(),
        'role': 'student',
        'phone': phone?.trim(),
      });

      // Create the student's student record.
      await _supabase.from('students').insert({
        'profile_id': user.id,
        'student_number': studentNumber.trim(),
        'course': course.trim(),
        'year_of_study': yearOfStudy,
      });

      isGuest = false;
      authMessage = null;

      return true;
    } on AuthException catch (e) {
      authMessage = e.message;
      return false;
    } on PostgrestException catch (e) {
      authMessage = 'Database error: ${e.message}';
      return false;
    } catch (e) {
      authMessage = 'Registration failed: $e';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Sign in an existing user.
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    authMessage = null;
    notifyListeners();

    try {
      await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      isGuest = false;
      authMessage = null;

      return true;
    } on AuthException catch (e) {
      authMessage = e.message;
      return false;
    } catch (e) {
      authMessage = 'Sign-in failed: $e';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Sign out from Supabase.
  Future<void> signOut() async {
    await _supabase.auth.signOut();

    isGuest = false;
    authMessage = null;

    notifyListeners();
  }
}