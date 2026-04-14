import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ FIX
import '../utils/app_theme.dart';
import '../utils/categories_data.dart';
import 'package:intl/intl.dart';
import 'map_picker_screen.dart';

// ✅ ADD THESE IMPORTS (VERY IMPORTANT)
import '../models/business_model.dart';
import '../services/app_state.dart'; // ✅ CORRECT PATH
import 'main_shell.dart'; // ✅ SAME FOLDER

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

  // 🔥 NEW FIELDS
  final _websiteController = TextEditingController();
  final _aboutController = TextEditingController();

  // 🔹 Profile Details
  String? selectedCategory;
  String? selectedSubcategory;
  String? selectedYear;
  final _addressController = TextEditingController();

  // 🔹 Map Location
  String? pickedLocation;

  // 🔹 Time
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  List<String> subcategories = [];

  void _onCategoryChanged(String? value) {
    setState(() {
      selectedCategory = value;
      selectedSubcategory = null;
      subcategories = CategoriesData.b2bCategories[value] ?? [];
    });
  }

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
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _aboutController.dispose();
    super.dispose();
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

              _buildTextField(
                "Business Name",
                _nameController,
                Icons.business,
                "Enter full business name",
              ),

              _buildTextField(
                "Mobile Number",
                _mobileController,
                Icons.phone,
                "10-digit number",
                isPhone: true,
              ),

              _buildTextField(
                "Email Address",
                _emailController,
                Icons.email,
                "email@business.com",
                isEmail: true,
              ),

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

              _buildTextField(
                "Business Address",
                _addressController,
                Icons.location_on,
                "Full street address...",
                isMultiline: true,
              ),

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

              // 🔥 NEW UI
              _buildTextField(
                "Website URL",
                _websiteController,
                Icons.language,
                "https://www.yourbusiness.com",
              ),

              _buildTextField(
                "About Business",
                _aboutController,
                Icons.info_outline,
                "Describe your business services...",
                isMultiline: true,
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryGreen,
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
    String hint, {
    bool isPhone = false,
    bool isEmail = false,
    bool isMultiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiline ? 3 : 1,
        keyboardType: isPhone
            ? TextInputType.phone
            : (isEmail ? TextInputType.emailAddress : TextInputType.text),
        validator: (value) {
          if (value == null || value.isEmpty) return "Required";
          if (isPhone && value.length != 10) return "Enter valid number";
          if (isEmail && !value.contains("@")) return "Invalid email";
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? value,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(labelText: label),
        validator: (val) => val == null ? "Required" : null,
      ),
    );
  }

  Widget _buildLocationPicker() {
    return OutlinedButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MapPickerScreen()),
        );
        if (result != null) setState(() => pickedLocation = result);
      },
      child: Text(pickedLocation ?? "Select Location"),
    );
  }

  Widget _buildTimeRow() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text("Open Time"),
            subtitle: Text(openTime?.format(context) ?? "--:--"),
            onTap: () => _selectTime(context, true),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text("Close Time"),
            subtitle: Text(closeTime?.format(context) ?? "--:--"),
            onTap: () => _selectTime(context, false),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (pickedLocation == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please select location")));
        return;
      }

      final newBusiness = B2BBusiness(
        id: DateTime.now().toString(),
        name: _nameController.text,
        category: selectedCategory!,
        subcategory: selectedSubcategory ?? "General",
        mobile: _mobileController.text,
        email: _emailController.text,
        websiteUrl: _websiteController.text,
        about: _aboutController.text,
        address: _addressController.text,
        startupYear: selectedYear ?? "",
        openTime: openTime?.format(context) ?? "09:00 AM",
        closeTime: closeTime?.format(context) ?? "06:00 PM",
        isVerified: true,
      );

      Provider.of<AppState>(context, listen: false).addBusiness(newBusiness);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Published Successfully")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    }
  }
}
