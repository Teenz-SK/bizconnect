// lib/services/data_service.dart

import '../models/business_model.dart';
import '../models/post_model.dart';

class DataService {
  // 🔹 MOCK B2B BUSINESS DATABASE (STRING BASED ✅)
  final List<B2BBusiness> _b2bBusinesses = [
    B2BBusiness(
      id: "1",
      name: "Global Steel Works",
      category: "Manufacturing",
      subcategory: "Industrial Machinery",
      mobile: "9876543210",
      email: "info@globalsteel.com",
      description: "Leading manufacturer of industrial steel components.",
      address: "Plot 42, Industrial Area, Phase 2",
      startupYear: "1995",
      openTime: "09:00 AM",
      closeTime: "06:00 PM",
      logoUrl: "GS",
      isVerified: true,
    ),
    B2BBusiness(
      id: "2",
      name: "MediTech Pharma",
      category: "Healthcare",
      subcategory: "Pharmaceuticals",
      mobile: "9123456789",
      email: "sales@meditech.com",
      description: "Trusted pharmaceutical supplier for hospitals.",
      address: "Medical Square, City Center",
      startupYear: "2010",
      openTime: "08:00 AM",
      closeTime: "10:00 PM",
      logoUrl: "MP",
      isVerified: true,
    ),
    B2BBusiness(
      id: "3",
      name: "CloudScale Systems",
      category: "Technology",
      subcategory: "Cloud Infrastructure",
      mobile: "9988776655",
      email: "support@cloudscale.com",
      description: "Enterprise cloud and DevOps solutions.",
      address: "Tech Park, Tower B",
      startupYear: "2015",
      openTime: "10:00 AM",
      closeTime: "07:00 PM",
      logoUrl: "CS",
    ),
    B2BBusiness(
      id: "4",
      name: "FreshMart Suppliers",
      category: "Food",
      subcategory: "Wholesale Supply",
      mobile: "9871234560",
      email: "bulk@freshmart.com",
      description: "Bulk supplier of fresh produce.",
      address: "Market Yard, Pune",
      startupYear: "2005",
      openTime: "06:00 AM",
      closeTime: "09:00 PM",
      logoUrl: "FM",
    ),
    B2BBusiness(
      id: "5",
      name: "Apex Manufacturing",
      category: "Manufacturing",
      subcategory: "Precision Tools",
      mobile: "9001122334",
      email: "ops@apex.com",
      description: "High precision industrial tools.",
      address: "MIDC Industrial Zone",
      startupYear: "2000",
      openTime: "09:30 AM",
      closeTime: "06:30 PM",
      logoUrl: "AM",
      isVerified: true,
    ),
  ];

  // 🔹 MOCK POSTS DATABASE
  final List<Post> _mockPosts = [
    Post(
      id: "p1",
      businessId: "1",
      businessName: "Global Steel Works",
      category: "Manufacturing",
      title: "New Machinery Line",
      content:
          "We have launched a new automated steel processing unit for bulk orders.",
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      id: "p2",
      businessId: "2",
      businessName: "MediTech Pharma",
      category: "Healthcare",
      title: "Bulk Medicine Supply",
      content:
          "Now accepting large-scale orders for hospitals.",
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  // 🔹 GET ALL BUSINESSES
  Future<List<B2BBusiness>> getBusinesses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _b2bBusinesses;
  }

  // 🔍 SEARCH + FILTER (STRING BASED ✅)
  Future<List<B2BBusiness>> searchBusinesses({
    String query = '',
    String? category, // ✅ FIXED (String instead of enum)
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _b2bBusinesses.where((business) {
      final matchesQuery =
          business.name.toLowerCase().contains(query.toLowerCase()) ||
          business.subcategory.toLowerCase().contains(query.toLowerCase());

      final matchesCategory =
          category == null ||
          category == "All" ||
          business.category.toLowerCase() == category.toLowerCase();

      return matchesQuery && matchesCategory;
    }).toList();
  }

  // 🔹 GET POSTS
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockPosts;
  }

  // 🔹 ADD POST
  Future<void> addPost(Post post) async {
    _mockPosts.insert(0, post);
  }
}