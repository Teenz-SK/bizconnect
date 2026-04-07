import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/categories_data.dart';
import 'package:intl/intl.dart';
import 'map_picker_screen.dart'; // ✅ IMPORTANT

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // 🔹 Basic Details
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  // 🔹 Profile Details
  String? selectedCategory;
  String? selectedSubcategory;
  String? selectedYear;
  final _addressController = TextEditingController();

  // 🔹 Map Location (NEW 🔥)
  String? pickedLocation;

  // 🔹 Time
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  List<String> subcategories = [];

  // 🔹 CATEGORY CHANGE
  void _onCategoryChanged(String? value) {
    setState(() {
      selectedCategory = value;
      selectedSubcategory = null;
      subcategories = CategoriesData.b2bCategories[value] ?? [];
    });
  }

  // 🔹 TIME PICKER
  Future<void> _selectTime(BuildContext context, bool isOpenTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isOpenTime) {
          openTime = picked;
        } else {
          closeTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("B2B Registration"),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("BASIC DETAILS"),
              const SizedBox(height: 16),

              _buildTextField("Business Name", _nameController,
                  Icons.business, "Enter full business name"),

              _buildTextField("Mobile Number", _mobileController,
                  Icons.phone, "10-digit number",
                  isPhone: true),

              _buildTextField("Email Address", _emailController,
                  Icons.email, "email@business.com",
                  isEmail: true),

              const SizedBox(height: 32),

              _buildSectionHeader("BUSINESS PROFILE DETAILS"),
              const SizedBox(height: 16),

              _buildDropdown(
                "Main Category",
                CategoriesData.b2bCategories.keys.toList(),
                selectedCategory,
                _onCategoryChanged,
              ),

              _buildDropdown(
                "Subcategory",
                subcategories,
                selectedSubcategory,
                (val) => setState(() => selectedSubcategory = val),
              ),

              _buildTextField("Business Address", _addressController,
                  Icons.location_on, "Full street address...",
                  isMultiline: true),

              // 🔥 MAP PICKER INTEGRATION
              _buildLocationPicker(),

              const SizedBox(height: 20),

              _buildTimeRow(),

              const SizedBox(height: 20),

              _buildDropdown(
                "Year of Startup",
                CategoriesData.getYears(),
                selectedYear,
                (val) => setState(() => selectedYear = val),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("COMPLETE REGISTRATION"),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 SECTION HEADER
  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppTheme.accentGold.withValues(alpha: 0.2),
        border: const Border(
          left: BorderSide(color: AppTheme.accentGold, width: 4),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryGreen,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // 🔹 TEXT FIELD
  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, String hint,
      {bool isPhone = false,
      bool isEmail = false,
      bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiline ? 3 : 1,
        keyboardType: isPhone
            ? TextInputType.phone
            : (isEmail
                ? TextInputType.emailAddress
                : TextInputType.text),
        validator: (value) {
          if (value == null || value.isEmpty) return "Required";
          if (isPhone && value.length != 10) return "Enter valid number";
          if (isEmail && !value.contains("@")) return "Invalid email";
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: AppTheme.primaryGreen),
        ),
      ),
    );
  }

  // 🔹 DROPDOWN
  Widget _buildDropdown(String label, List<String> items, String? value,
      Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((item) =>
                DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              const Icon(Icons.category, color: AppTheme.primaryGreen),
        ),
        validator: (val) => val == null ? "Required" : null,
      ),
    );
  }

  // 🔥 MAP PICKER BUTTON (FINAL VERSION)
  Widget _buildLocationPicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: OutlinedButton.icon(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MapPickerScreen(),
            ),
          );

          if (result != null) {
            setState(() => pickedLocation = result);
          }
        },
        icon: Icon(
          pickedLocation == null
              ? Icons.map_outlined
              : Icons.check_circle,
          color: AppTheme.primaryGreen,
        ),
        label: Text(
          pickedLocation ?? "SELECT LOCATION ON MAP",
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primaryGreen,
          side: BorderSide(
            color: pickedLocation == null
                ? AppTheme.primaryGreen
                : Colors.green,
            width: 2,
          ),
          minimumSize: const Size(double.infinity, 55),
        ),
      ),
    );
  }

  // 🔹 TIME ROW
  Widget _buildTimeRow() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title:
                const Text("Open Time", style: TextStyle(fontSize: 12)),
            subtitle:
                Text(openTime?.format(context) ?? "--:--"),
            onTap: () => _selectTime(context, true),
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ListTile(
            title:
                const Text("Close Time", style: TextStyle(fontSize: 12)),
            subtitle:
                Text(closeTime?.format(context) ?? "--:--"),
            onTap: () => _selectTime(context, false),
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  // 🔹 SUBMIT
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (pickedLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select location")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("B2B Profile Created Successfully!"),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );
    }
  }
}