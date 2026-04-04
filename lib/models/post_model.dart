class Post {
  final String id;
  final String businessId;
  final String businessName;
  final String category;
  final String title;
  final String content;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.businessId,
    required this.businessName,
    required this.category,
    required this.title,
    required this.content,
    required this.timestamp,
  });
}