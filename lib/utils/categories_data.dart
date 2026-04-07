class CategoriesData {
  static const Map<String, List<String>> b2bCategories = {
    "Manufacturing": [
      "Textiles",
      "Chemicals",
      "Automotive Parts",
      "Industrial Machinery",
    ],
    "Healthcare": ["Medical Devices", "Pharmaceuticals", "Hospital Supplies"],
    "IT & Tech": [
      "Software Development",
      "Hardware Wholesale",
      "Cloud Services",
    ],
    "Retail": [
      "FMCG Wholesalers",
      "Electronics Retail",
      "Apparel Distribution",
    ],
  };

  static List<String> getYears() {
    return List.generate(
      30,
      (index) => (DateTime.now().year - index).toString(),
    );
  }
}
