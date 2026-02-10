import 'package:flutter/material.dart';
import '/modals/add_password_sheet.dart';
import 'package:flutter/services.dart'; // Clipboard

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, String>> _passwords = [];

  // Filter passwords by category
  List<Map<String, String>> getPasswordsForCategory(String category) {
    if (category == "All") return _passwords;
    return _passwords.where((p) => p["category"] == category).toList();
  }

  // Build ListView for a category
  Widget _buildPasswordList(String category) {
    final filtered = getPasswordsForCategory(category);

    if (filtered.isEmpty) {
      return const Center(
        child: Text("No passwords", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return ListTile(
          title: Text(
            item["title"] ?? "",
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            item["username"] ?? "",
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: item["password"] ?? ""));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Password copied")));
            },
          ),
          onTap: () async {
            // Open modal to edit the password
            final updated = await showModalBottomSheet<Map<String, String>>(
              context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xFF1F1F1F),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (_) => AddPasswordSheet(initialData: item),
            );

            if (updated != null) {
              setState(() {
                // Update original item in _passwords
                final originalIndex = _passwords.indexOf(item);
                _passwords[originalIndex] = updated;
              });
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          title: const Text(
            "Passkeeper",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: const Color(0xFF121212),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF282828),
                  hintText: "Search password",
                  hintStyle: const TextStyle(color: Color(0xFF8B8B8B)),
                  suffixIcon: const Icon(Icons.search, color: Colors.white),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: const Color(0xFF121212),
              child: const TabBar(
                labelColor: Color(0xFFEE6AF3),
                unselectedLabelColor: Colors.white,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xFFEE6AF3), width: 4),
                  insets: EdgeInsets.zero,
                ),
                tabs: [
                  Tab(text: "All"),
                  Tab(text: "Social"),
                  Tab(text: "Games"),
                  Tab(text: "Work"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPasswordList("All"),
                  _buildPasswordList("Social"),
                  _buildPasswordList("Games"),
                  _buildPasswordList("Work"),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () async {
            final newPassword = await showModalBottomSheet<Map<String, String>>(
              context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xFF1F1F1F),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (_) => const AddPasswordSheet(),
            );

            if (newPassword != null) {
              setState(() {
                _passwords.add(newPassword);
              });
            }
          },
          backgroundColor: const Color(0xFFEE6AF3),
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}
