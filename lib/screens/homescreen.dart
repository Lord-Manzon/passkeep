import 'package:flutter/material.dart';
import '/modals/add_password_sheet.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // number of categories
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
            // TabBar
            Container(
              color: const Color(0xFF121212),
              child: TabBar(
                labelColor: const Color(0xFFEE6AF3), // active text
                unselectedLabelColor: Colors.white, // inactive text
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xFFEE6AF3), width: 4),
                  insets: EdgeInsets.zero,
                ), // removes default spacing that shows a gray line
                // thickness of the line
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Work"),
                  Tab(text: "Social"),
                  Tab(text: "Games"),
                ],
              ),
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: Text(
                      "All passwords",
                      style: TextStyle(color: const Color(0xFF8B8B8B)),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Work passwords",
                      style: TextStyle(color: const Color(0xFF8B8B8B)),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Social passwords",
                      style: TextStyle(color: const Color(0xFF8B8B8B)),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Bank passwords",
                      style: TextStyle(color: const Color(0xFF8B8B8B)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: const Color(0xFF1F1F1F),
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (_) => const AddPasswordSheet(),
            );
          },

          backgroundColor: const Color(0xFFEE6AF3),
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}
