import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _supabase = Supabase.instance.client;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _studentNumberController = TextEditingController();
  final _courseController = TextEditingController();

  int? _yearOfStudy;
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = _supabase.auth.currentUser;

      if (user == null) {
        throw Exception('Please sign in first.');
      }

      final profile = await _supabase
          .from('profiles')
          .select(
            'full_name, phone, student_number, course, year_of_study',
          )
          .eq('id', user.id)
          .maybeSingle();

      if (profile == null) {
        throw Exception(
          'Your profile was not found. Please contact the administrator.',
        );
      }

      if (!mounted) return;

      _nameController.text = profile['full_name']?.toString() ?? '';
      _phoneController.text = profile['phone']?.toString() ?? '';
      _studentNumberController.text =
          profile['student_number']?.toString() ?? '';
      _courseController.text = profile['course']?.toString() ?? '';

      final year = profile['year_of_study'];
      _yearOfStudy = year == null ? null : int.tryParse(year.toString());

      setState(() {
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final user = _supabase.auth.currentUser;

    if (user == null) {
      setState(() => _error = 'Please sign in again.');
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      await _supabase.from('profiles').update({
        'full_name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'student_number': _studentNumberController.text.trim(),
        'course': _courseController.text.trim(),
        'year_of_study': _yearOfStudy,
      }).eq('id', user.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = 'Could not update profile. $e';
      });
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _studentNumberController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null &&
                  _nameController.text.isEmpty &&
                  _studentNumberController.text.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      _error!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CircleAvatar(
                            radius: 38,
                            child: Icon(Icons.person, size: 42),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Update your personal details',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          _textField(
                            label: 'Full name',
                            controller: _nameController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Enter your full name'
                                    : null,
                          ),

                          _textField(
                            label: 'Phone number',
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),

                          _textField(
                            label: 'Student number',
                            controller: _studentNumberController,
                          ),

                          _textField(
                            label: 'Course',
                            controller: _courseController,
                          ),

                          DropdownButtonFormField<int>(
                            value: _yearOfStudy,
                            decoration: const InputDecoration(
                              labelText: 'Year of study',
                              border: OutlineInputBorder(),
                            ),
                            items: List.generate(
                              6,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text('Year ${index + 1}'),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() => _yearOfStudy = value);
                            },
                            validator: (value) => value == null
                                ? 'Select your year of study'
                                : null,
                          ),

                          const SizedBox(height: 20),

                          if (_error != null) ...[
                            Text(
                              _error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 12),
                          ],

                          FilledButton(
                            onPressed: _saving ? null : _saveProfile,
                            child: _saving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Save Changes'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}