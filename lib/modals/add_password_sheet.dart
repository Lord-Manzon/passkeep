import 'package:flutter/material.dart';

class AddPasswordSheet extends StatefulWidget {
  final Map<String, String>? initialData;

  const AddPasswordSheet({super.key, this.initialData});

  @override
  State<AddPasswordSheet> createState() => _AddPasswordSheetState();
}

class _AddPasswordSheetState extends State<AddPasswordSheet> {
  late TextEditingController _titleController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _hidePassword = true;
  String _selectedCategory = "All";

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data if editing
    _titleController = TextEditingController(
      text: widget.initialData?["title"] ?? "",
    );
    _usernameController = TextEditingController(
      text: widget.initialData?["username"] ?? "",
    );
    _passwordController = TextEditingController(
      text: widget.initialData?["password"] ?? "",
    );
    _selectedCategory = widget.initialData?["category"] ?? "All";
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialData != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? "Edit Password" : "Add Password",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),

          const SizedBox(height: 16),

          _input("Title", controller: _titleController),
          const SizedBox(height: 12),
          _input("Username / Email", controller: _usernameController),
          const SizedBox(height: 12),
          _input(
            "Password",
            controller: _passwordController,
            obscure: _hidePassword,
            suffix: IconButton(
              icon: Icon(
                _hidePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: _selectedCategory,
            dropdownColor: const Color(0xFF282828),
            items: ["All", "Work", "Social", "Games"]
                .map(
                  (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c, style: const TextStyle(color: Colors.white)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF282828),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE6AF3),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context, {
                  "title": _titleController.text,
                  "username": _usernameController.text,
                  "password": _passwordController.text,
                  "category": _selectedCategory,
                });
              },
              child: Text(isEditing ? "Update" : "Save"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(
    String hint, {
    bool obscure = false,
    TextEditingController? controller,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8B8B8B)),
        filled: true,
        fillColor: const Color(0xFF282828),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffix,
      ),
    );
  }
}
