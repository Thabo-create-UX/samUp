import '../models/activity_item.dart';
import '../models/agreement.dart';
import '../models/payment.dart';
import '../models/room.dart';
import '../models/student.dart';
import '../models/term_item.dart';

class AccommodationRepository {
  Future<Student> getCurrentStudent() async {
    return const Student(
      id: 'student-001',
      fullName: 'Thabo Kayane',
      studentNumber: '219015324',
      email: 'thabo@example.com',
      phone: '071 000 0000',
      institution: 'Central University of Technology',
      course: 'Diploma in Information Technology',
      emergencyContactName: 'Emergency Contact',
      emergencyContactPhone: '072 000 0000',
      roomId: 'room-101',
      isActiveResident: true,
    );
  }

  Future<List<Room>> getRooms() async {
    return const [
      Room(
        id: 'room-101',
        name: 'Room 101',
        blockAndFloor: 'Block A • Ground Floor',
        roomType: 'Single Room',
        bedsLabel: '1 Bed',
        monthlyRent: 3500.00,
        imageAsset: '',
        amenities: [
          'Wi-Fi',
          'Study desk',
          'Wardrobe',
          'Bed',
          'Shared kitchen',
        ],
        occupancy: RoomOccupancy.occupied,
      ),
      Room(
        id: 'room-102',
        name: 'Room 102',
        blockAndFloor: 'Block A • Ground Floor',
        roomType: 'Shared Room',
        bedsLabel: '2 Beds',
        monthlyRent: 2800.00,
        imageAsset: '',
        amenities: [
          'Wi-Fi',
          'Study desk',
          'Wardrobe',
          'Shared kitchen',
        ],
        occupancy: RoomOccupancy.partlyOccupied,
      ),
      Room(
        id: 'room-201',
        name: 'Room 201',
        blockAndFloor: 'Block A • First Floor',
        roomType: 'Single Room',
        bedsLabel: '1 Bed',
        monthlyRent: 3700.00,
        imageAsset: '',
        amenities: [
          'Wi-Fi',
          'Study desk',
          'Wardrobe',
          'Bed',
          'Shared kitchen',
        ],
        occupancy: RoomOccupancy.available,
      ),
    ];
  }

  Future<List<Agreement>> getAgreements(String studentId) async {
    return [
      Agreement(
        id: 'agreement-001',
        reference: 'AGR-2026-001',
        studentId: studentId,
        studentName: 'Thabo Kayane',
        roomId: 'room-101',
        roomName: 'Room 101',
        blockAndFloor: 'Block A • Ground Floor',
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 12, 31),
        leaseTermLabel: '12 Months',
        monthlyRent: 3500.00,
        deposit: 3500.00,
        depositPaid: true,
        status: AgreementStatus.active,
      ),
    ];
  }

  Future<List<Payment>> getPayments(String agreementId) async {
    return [
      Payment(
        id: 'payment-001',
        reference: 'PAY-2026-01',
        agreementId: agreementId,
        periodLabel: 'January 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 1, 5),
        paidDate: DateTime(2026, 1, 3),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-002',
        reference: 'PAY-2026-02',
        agreementId: agreementId,
        periodLabel: 'February 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 2, 5),
        paidDate: DateTime(2026, 2, 3),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-003',
        reference: 'PAY-2026-03',
        agreementId: agreementId,
        periodLabel: 'March 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 3, 5),
        paidDate: DateTime(2026, 3, 4),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-004',
        reference: 'PAY-2026-04',
        agreementId: agreementId,
        periodLabel: 'April 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 4, 5),
        paidDate: DateTime(2026, 4, 3),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-005',
        reference: 'PAY-2026-05',
        agreementId: agreementId,
        periodLabel: 'May 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 5, 5),
        paidDate: DateTime(2026, 5, 2),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-006',
        reference: 'PAY-2026-06',
        agreementId: agreementId,
        periodLabel: 'June 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 6, 5),
        paidDate: DateTime(2026, 6, 4),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-007',
        reference: 'PAY-2026-07',
        agreementId: agreementId,
        periodLabel: 'July 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 7, 5),
        paidDate: DateTime(2026, 7, 3),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-008',
        reference: 'PAY-2026-08',
        agreementId: agreementId,
        periodLabel: 'August 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 8, 5),
        paidDate: DateTime(2026, 8, 4),
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.paid,
      ),
      Payment(
        id: 'payment-009',
        reference: 'PAY-2026-09',
        agreementId: agreementId,
        periodLabel: 'September 2026',
        amount: 3500.00,
        dueDate: DateTime(2026, 9, 5),
        paidDate: null,
        method: 'EFT',
        bankName: 'FNB',
        accountNumber: '****1234',
        status: PaymentStatus.pending,
      ),
    ];
  }

  Future<List<TermItem>> getTerms() async {
    return const [
      TermItem(
        number: 1,
        title: 'Monthly Rental Payment',
        description:
            'Monthly rental payments must be made by the agreed due date.',
      ),
      TermItem(
        number: 2,
        title: 'Property Care',
        description:
            'Students must take reasonable care of the room, furniture and shared facilities.',
      ),
      TermItem(
        number: 3,
        title: 'Noise and Conduct',
        description:
            'Students must respect other residents and avoid excessive noise.',
      ),
      TermItem(
        number: 4,
        title: 'Visitors',
        description:
            'Visitors must comply with the accommodation rules and security requirements.',
      ),
      TermItem(
        number: 5,
        title: 'Damage',
        description:
            'The student may be responsible for costs resulting from damage caused through negligence or misuse.',
      ),
      TermItem(
        number: 6,
        title: 'Termination',
        description:
            'The rental agreement may be terminated according to the conditions contained in the signed agreement.',
      ),
    ];
  }

  Future<List<ActivityItem>> getRecentActivity() async {
    return const [
      ActivityItem(
        title: 'Payment pending',
        subtitle: 'September 2026 rental payment is outstanding.',
        type: ActivityType.payment,
      ),
      ActivityItem(
        title: 'Agreement active',
        subtitle: 'Your rental agreement is currently active.',
        type: ActivityType.agreement,
      ),
      ActivityItem(
        title: 'Accommodation assigned',
        subtitle: 'Room 101 has been assigned to your profile.',
        type: ActivityType.agreement,
      ),
    ];
  }
}