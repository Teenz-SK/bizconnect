enum BusinessCategory {
  technology,
  manufacturing,
  healthcare,
  services,
  retail,
  food,
}

class Business {
  final String id;
  final String name;
  final String category;
  final String description;
  final String logoUrl;
  final String contact;
  final String location;
  final bool isVerified;

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.logoUrl,
    required this.contact,
    this.location = "Remote / Global",
    this.isVerified = false,
  });
}