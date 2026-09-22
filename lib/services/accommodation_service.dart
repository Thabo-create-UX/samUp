import '../models/activity_item.dart';
import '../models/agreement.dart';
import '../models/payment.dart';
import '../models/room.dart';
import '../models/student.dart';
import '../models/term_item.dart';
import '../repositories/accommodation_repository.dart';

class AccommodationData {
  final Student student;
  final List<Room> rooms;
  final List<Agreement> agreements;
  final List<Payment> payments;
  final List<TermItem> terms;
  final List<ActivityItem> activity;

  const AccommodationData({
    required this.student,
    required this.rooms,
    required this.agreements,
    required this.payments,
    required this.terms,
    required this.activity,
  });

  Agreement? get activeAgreement {
    for (final agreement in agreements) {
      if (agreement.status == AgreementStatus.active) return agreement;
    }
    return agreements.isEmpty ? null : agreements.first;
  }

  Room? get assignedRoom {
    for (final room in rooms) {
      if (room.id == student.roomId) return room;
    }
    return rooms.isEmpty ? null : rooms.first;
  }

  List<Payment> get pendingPayments =>
      payments.where((p) => p.status == PaymentStatus.pending).toList();

  double get outstandingBalance =>
      pendingPayments.fold(0.0, (sum, p) => sum + p.amount);

  Payment? get nextDuePayment {
    final pending = pendingPayments;
    if (pending.isEmpty) return null;
    pending.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return pending.first;
  }
}

class AccommodationService {
  final AccommodationRepository repository;

  AccommodationService({required this.repository});

  Future<AccommodationData> load() async {
    final student = await repository.getCurrentStudent();
    final rooms = await repository.getRooms();
    final agreements = await repository.getAgreements(student.id);
    final agreementId = agreements.isEmpty ? '' : agreements.first.id;
    final payments = await repository.getPayments(agreementId);
    final terms = await repository.getTerms();
    final activity = await repository.getRecentActivity();
    return AccommodationData(
      student: student,
      rooms: rooms,
      agreements: agreements,
      payments: payments,
      terms: terms,
      activity: activity,
    );
  }
}
