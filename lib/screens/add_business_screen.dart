import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/gradient_button.dart';
import '../utils/app_theme.dart';
import '../models/business_model.dart';
import '../services/app_state.dart';

class AddBusinessScreen extends StatefulWidget {
  final VoidCallback? onSuccess;

  const AddBusinessScreen({super.key, this.onSuccess});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final _formKey = GlobalKey<FormState>();

  // 🔥 CONTROLLERS
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _descController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  // 🔥 MAIN LOGIC
  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      final newBiz = Business(
        id: DateTime.now().toString(),
        name: _nameController.text,
        category: _categoryController.text,
        description: _descController.text,
        logoUrl: _nameController.text.isNotEmpty
            ? _nameController.text[0]
            : "B",
        contact: _contactController.text,
        isVerified: false,
      );

      // 🔥 SAVE TO GLOBAL STATE
      Provider.of<AppState>(context, listen: false).addBusiness(newBiz);

      // ✅ FEEDBACK
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Business added to Home Screen!")),
      );

      // ✅ RESET
      _nameController.clear();
      _categoryController.clear();
      _descController.clear();
      _contactController.clear();

      // ✅ SWITCH TAB
      widget.onSuccess?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Your Business")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Business Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                "Business Name",
                "e.g. Acme Tech Solutions",
                controller: _nameController,
              ),
              _buildTextField(
                "Category",
                "e.g. Technology",
                controller: _categoryController,
              ),
              _buildTextField(
                "Phone / WhatsApp",
                "+91 98765 43210",
                controller: _contactController,
              ),
              _buildTextField(
                "Short Bio",
                "Tell people what you do...",
                maxLines: 3,
                controller: _descController,
              ),

              const SizedBox(height: 30),

              GradientButton(
                text: "Register Business",
                onPressed: _handleRegister, // 🔥 CLEAN CALL
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint, {
    int maxLines = 1,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
