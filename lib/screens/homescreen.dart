import 'package:flutter/material.dart';
import '/modals/add_password_sheet.dart';
import 'package:flutter/services.dart'; //cclipboard

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, String>> _passwords = [];
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  // Build a ListView for category tabs
  Widget _buildPasswordList(String category) {
    final filtered = _passwords
        .where((p) => p["category"] == category)
        .toList();

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
            item["title"]!,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            item["username"]!,
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
                final originalIndex = _passwords.indexOf(item);
                _passwords[originalIndex] = updated;
              });
            }
          },
        );
      },
    );
  }

  // Build ListView for All tab with search
  Widget _buildAllPasswords() {
    final filtered = _passwords.where((p) {
      final query = _searchQuery.toLowerCase();
      return (p["title"] ?? "").toLowerCase().contains(query) ||
          (p["username"] ?? "").toLowerCase().contains(query);
    }).toList();

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
            item["title"]!,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            item["username"]!,
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
    // Inside your build() before TabBar
    final allCount = _passwords.length;
    final socialCount = _passwords
        .where((p) => p["category"] == "Social")
        .length;
    final gamesCount = _passwords.where((p) => p["category"] == "Games").length;
    final workCount = _passwords.where((p) => p["category"] == "Work").length;

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
                controller: _searchController,
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
              child: TabBar(
                labelColor: const Color(0xFFEE6AF3),
                unselectedLabelColor: Colors.white,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xFFEE6AF3), width: 4),
                  insets: EdgeInsets.zero,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("All"),
                        const SizedBox(width: 6),
                        if (allCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$allCount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Social"),
                        const SizedBox(width: 6),
                        if (socialCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$socialCount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Games"),
                        const SizedBox(width: 6),
                        if (gamesCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 112, 81, 79),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$gamesCount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Work"),
                        const SizedBox(width: 6),
                        if (workCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$workCount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  _buildAllPasswords(),
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
