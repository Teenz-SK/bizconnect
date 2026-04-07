// lib/models/business_model.dart

// 🔥 FINAL FIXED B2B MODEL (Backward Compatible + Flexible)

class B2BBusiness {
  final String id;
  final String name;

  // 🔹 CATEGORY (Changed to String → fixes dropdown + enum issues)
  final String category;

  // 📞 Contact Info
  final String mobile;
  final String email;

  // 🏢 Business Info
  final String description;
  final String logoUrl;
  final String subcategory;

  // 📍 Location Info
  final String address;
  final String? latitude;
  final String? longitude;

  // 🕒 Business Details
  final String startupYear;
  final String openTime;
  final String closeTime;

  // 🌐 Status
  final bool isVerified;

  B2BBusiness({
    required this.id,
    required this.name,
    required this.category,

    // 🔥 OPTIONAL FIELDS (fixes 30+ errors)
    this.mobile = "",
    this.email = "",
    this.description = "",
    this.logoUrl = "B",
    this.subcategory = "General",
    this.address = "",
    this.startupYear = "",
    this.openTime = "",
    this.closeTime = "",
    this.latitude,
    this.longitude,
    this.isVerified = false,
  });

  // 🔥 BACKWARD COMPATIBILITY FIX
  // Old code uses "contact"
  String get contact => mobile;

  // 🔄 TO MAP (API / DB READY)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'mobile': mobile,
      'email': email,
      'description': description,
      'logoUrl': logoUrl,
      'subcategory': subcategory,
      'address': address,
      'startupYear': startupYear,
      'openTime': openTime,
      'closeTime': closeTime,
      'latitude': latitude,
      'longitude': longitude,
      'isVerified': isVerified,
    };
  }

  // 🔄 FROM MAP
  factory B2BBusiness.fromMap(Map<String, dynamic> map) {
    return B2BBusiness(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      mobile: map['mobile'] ?? '',
      email: map['email'] ?? '',
      description: map['description'] ?? '',
      logoUrl: map['logoUrl'] ?? 'B',
      subcategory: map['subcategory'] ?? 'General',
      address: map['address'] ?? '',
      startupYear: map['startupYear'] ?? '',
      openTime: map['openTime'] ?? '',
      closeTime: map['closeTime'] ?? '',
      latitude: map['latitude'],
      longitude: map['longitude'],
      isVerified: map['isVerified'] ?? false,
    );
  }

  // 🔁 COPY WITH
  B2BBusiness copyWith({
    String? id,
    String? name,
    String? category,
    String? mobile,
    String? email,
    String? description,
    String? logoUrl,
    String? subcategory,
    String? address,
    String? startupYear,
    String? openTime,
    String? closeTime,
    String? latitude,
    String? longitude,
    bool? isVerified,
  }) {
    return B2BBusiness(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      subcategory: subcategory ?? this.subcategory,
      address: address ?? this.address,
      startupYear: startupYear ?? this.startupYear,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

// 🔥🔥🔥 CRITICAL FIX (DO NOT REMOVE)
typedef Business = B2BBusiness;