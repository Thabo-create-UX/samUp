import 'package:flutter/foundation.dart';

import '../models/load_status.dart';
import '../services/accommodation_service.dart';

class AccommodationProvider extends ChangeNotifier {
  final AccommodationService service;

  AccommodationProvider({required this.service});

  LoadStatus status = LoadStatus.loading;
  AccommodationData? data;
  String? errorMessage;
  String searchQuery = '';

  Future<void> load() async {
    status = LoadStatus.loading;
    errorMessage = null;
    notifyListeners();
    try {
      data = await service.load();
      status = LoadStatus.loaded;
    } catch (e) {
      errorMessage = 'We could not load your accommodation details. Please try again.';
      status = LoadStatus.error;
    }
    notifyListeners();
  }

  void setSearchQuery(String value) {
    searchQuery = value;
    notifyListeners();
  }
}
