import 'package:flutter/material.dart';
import '../models/business_model.dart';
import 'data_service.dart';

class AppState extends ChangeNotifier {
  List<Business> _businesses = [];
  bool _isLoading = true;

  final DataService _dataService = DataService();

  // 🔹 GETTERS
  List<Business> get businesses => _businesses;
  bool get isLoading => _isLoading;

  // 🔥 INITIALIZE (FIXED WITH TRY-CATCH)
  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      _businesses = await _dataService.getBusinesses();
    } catch (e) {
      debugPrint("Error loading data: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // ✅ ALWAYS stops loader
    }
  }

  // 🔹 ADD NEW BUSINESS (REAL-TIME UPDATE)
  void addBusiness(Business biz) {
    _businesses.insert(0, biz); // latest on top
    notifyListeners();
  }
}