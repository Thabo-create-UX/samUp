import 'package:flutter/foundation.dart';

/// Represents the student's session. No backend is connected yet, so the only
/// working path is a local guest session; signIn reports the not-connected state
/// rather than pretending to authenticate.
class AuthProvider extends ChangeNotifier {
  bool isGuest = false;
  String? authMessage;

  void continueAsGuest() {
    isGuest = true;
    authMessage = null;
    notifyListeners();
  }

  void attemptSignIn() {
    authMessage = 'Sign-in needs a connected backend. Continue as guest to explore StayFlow on this device.';
    notifyListeners();
  }

  void signOut() {
    isGuest = false;
    notifyListeners();
  }
}
