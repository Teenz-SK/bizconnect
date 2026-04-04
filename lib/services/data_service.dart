import '../models/business_model.dart';
import '../models/post_model.dart';

class DataService {
  // 🔹 MOCK BUSINESS DATABASE
  final List<Business> _allBusinesses = [
    Business(
      id: "1",
      name: "TechNova Solutions",
      category: "Technology",
      description: "Custom software and AI integrations.",
      logoUrl: "TN",
      contact: "contact@technova.com",
    ),
    Business(
      id: "2",
      name: "GreenLeaf Organics",
      category: "Food & Beverage",
      description: "Farm-to-table organic distribution.",
      logoUrl: "GL",
      contact: "hello@greenleaf.com",
    ),
    Business(
      id: "3",
      name: "Apex Manufacturing",
      category: "Manufacturing",
      description: "Precision tools and industrial parts.",
      logoUrl: "AM",
      contact: "ops@apex.com",
      isVerified: true,
    ),
    Business(
      id: "4",
      name: "CloudScale Systems",
      category: "Technology",
      description: "Cloud infrastructure and security.",
      logoUrl: "CS",
      contact: "support@cloudscale.com",
      isVerified: true,
    ),
    Business(
      id: "5",
      name: "Urban Estates",
      category: "Real Estate",
      description: "Commercial property management.",
      logoUrl: "UE",
      contact: "info@urbanestates.com",
    ),
  ];

  // 🔹 MOCK POSTS DATABASE (NEW)
  final List<Post> _mockPosts = [
    Post(
      id: "p1",
      businessId: "1",
      businessName: "TechNova Solutions",
      category: "Technology",
      title: "New AI Integration Launch",
      content:
          "We just launched our new AI-driven analytics dashboard for small businesses. Check it out!",
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      id: "p2",
      businessId: "2",
      businessName: "GreenLeaf Organics",
      category: "Food & Beverage",
      title: "Fresh Harvest Alert!",
      content:
          "Our organic avocados are back in stock. B2B bulk orders open now.",
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  // 🔹 GET BUSINESSES
  Future<List<Business>> getBusinesses() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate API
    return _allBusinesses;
  }

  // 🔹 GET POSTS (NEW)
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockPosts;
  }

  // 🔹 ADD POST (FUTURE READY)
  Future<void> addPost(Post post) async {
    _mockPosts.insert(0, post); // latest on top
  }
}