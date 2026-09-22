enum PaymentStatus { paid, pending }

class Payment {
  final String id;
  final String reference;
  final String agreementId;
  final String periodLabel;
  final double amount;
  final DateTime dueDate;
  final DateTime? paidDate;
  final String method;
  final String bankName;
  final String accountNumber;
  final PaymentStatus status;

  const Payment({
    required this.id,
    required this.reference,
    required this.agreementId,
    required this.periodLabel,
    required this.amount,
    required this.dueDate,
    this.paidDate,
    required this.method,
    required this.bankName,
    required this.accountNumber,
    required this.status,
  });

  bool get isPaid => status == PaymentStatus.paid;

  String get statusLabel => isPaid ? 'Paid' : 'Pending';
}
