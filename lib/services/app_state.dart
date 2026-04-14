import 'package:flutter/material.dart';
import '../models/business_model.dart';
import 'data_service.dart';

class AppState extends ChangeNotifier {
  List<B2BBusiness> _b2bBusinesses = [];
  bool _isLoading = true;

  final DataService _dataService = DataService();

  List<B2BBusiness> get b2bBusinesses => _b2bBusinesses;

  // 🔥 BACKWARD COMPATIBILITY
  List<B2BBusiness> get businesses => _b2bBusinesses;

  bool get isLoading => _isLoading;

  // 🔥 INITIAL LOAD
  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      _b2bBusinesses = await _dataService.getBusinesses();
    } catch (e) {
      debugPrint("Error loading data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 🔥 ADD BUSINESS (FEED AUTO UPDATE)
  void addBusiness(B2BBusiness biz) {
    _b2bBusinesses.insert(0, biz);
    notifyListeners();
  }

  // 🔍 SEARCH
  List<B2BBusiness> searchBusinesses(String query) {
    return _b2bBusinesses.where((b) {
      return b.name.toLowerCase().contains(query.toLowerCase()) ||
          b.subcategory.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // 🏷️ FILTER
  List<B2BBusiness> filterByCategory(String category) {
    if (category == "All") return _b2bBusinesses;

    return _b2bBusinesses.where((b) {
      return b.category.toLowerCase() == category.toLowerCase();
    }).toList();
  }
}
