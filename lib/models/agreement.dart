enum AgreementStatus { active, pendingVerification, ended }

class Agreement {
  final String id;
  final String reference;
  final String studentId;
  final String studentName;
  final String roomId;
  final String roomName;
  final String blockAndFloor;
  final DateTime startDate;
  final DateTime endDate;
  final String leaseTermLabel;
  final double monthlyRent;
  final double deposit;
  final bool depositPaid;
  final AgreementStatus status;

  const Agreement({
    required this.id,
    required this.reference,
    required this.studentId,
    required this.studentName,
    required this.roomId,
    required this.roomName,
    required this.blockAndFloor,
    required this.startDate,
    required this.endDate,
    required this.leaseTermLabel,
    required this.monthlyRent,
    required this.deposit,
    required this.depositPaid,
    required this.status,
  });

  String get statusLabel {
    switch (status) {
      case AgreementStatus.active:
        return 'Active';
      case AgreementStatus.pendingVerification:
        return 'Pending Verification';
      case AgreementStatus.ended:
        return 'Ended';
    }
  }

  /// Share of the lease already elapsed, derived from the current date so the
  /// progress bar moves without any stored "current month" field.
  double get progress {
    final total = endDate.difference(startDate).inDays;
    if (total <= 0) return 0;
    final elapsed = DateTime.now().difference(startDate).inDays;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  int get monthsRemaining {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return ((endDate.year - now.year) * 12 + endDate.month - now.month).clamp(0, 240);
  }
}
