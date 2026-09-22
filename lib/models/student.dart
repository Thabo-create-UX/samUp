class Student {
  final String id;
  final String fullName;
  final String studentNumber;
  final String email;
  final String phone;
  final String institution;
  final String course;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String roomId;
  final bool isActiveResident;

  const Student({
    required this.id,
    required this.fullName,
    required this.studentNumber,
    required this.email,
    required this.phone,
    required this.institution,
    required this.course,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.roomId,
    required this.isActiveResident,
  });

  String get firstName => fullName.split(' ').first;

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'.toUpperCase();
  }
}
