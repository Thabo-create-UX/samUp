enum RoomOccupancy { occupied, partlyOccupied, available }

class Room {
  final String id;
  final String name;
  final String blockAndFloor;
  final String roomType;
  final String bedsLabel;
  final double monthlyRent;
  final String imageAsset;
  final List<String> amenities;
  final RoomOccupancy occupancy;

  const Room({
    required this.id,
    required this.name,
    required this.blockAndFloor,
    required this.roomType,
    required this.bedsLabel,
    required this.monthlyRent,
    required this.imageAsset,
    required this.amenities,
    required this.occupancy,
  });

  String get occupancyLabel {
    switch (occupancy) {
      case RoomOccupancy.occupied:
        return 'Occupied';
      case RoomOccupancy.partlyOccupied:
        return '1 Bed Occupied';
      case RoomOccupancy.available:
        return 'Available';
    }
  }
}
