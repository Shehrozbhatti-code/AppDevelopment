import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'subjects_screen.dart';
import 'note_detail_screen.dart';
import 'login_screen.dart'; // We import this so we can log out!

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Note> searchResults = globalNotes.where((note) {
      return note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.subject.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Keeps the row tight in the center
          children: [
            Icon(Icons.school, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text('NotesShare', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: const [
          // balances out the Drawer icon on the left,
          SizedBox(width: 48),
        ],
      ),


      // THE NAVIGATION DRAWER

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // The colored header at the top of the Drawer
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              accountName: Text(
                "Student User",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text("student@university.edu"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.school, size: 40, color: Colors.blueAccent),
              ),
            ),

            // Menu Item 1: Home
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blueAccent),
              title: const Text('Home'),
              onTap: () {
                // This simply slides the drawer closed
                Navigator.pop(context);
              },
            ),

            // Menu Item 2: Profile (Dummy button for Phase 1)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile page coming in Phase 2!')),
                );
              },
            ),

            // Menu Item 3: Settings (Dummy button for Phase 1)
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings coming in Phase 2!')),
                );
              },
            ),

            const Divider(thickness: 1), // A visual line to separate the logout button

            // Menu Item 4: Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                // This removes all screens and sends the user safely back to the Login Screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      // ---------------------------------------------

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for notes or subjects...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildSemesterList()
                : _buildSearchResults(searchResults),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterList() {
    return ListView.builder(
      itemCount: semestersList.length,
      itemBuilder: (context, index) {
        String semester = semestersList[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(semester, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubjectsScreen(semester: semester)),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(List<Note> results) {
    if (results.isEmpty) {
      return const Center(child: Text('No notes found for your search.'));
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        Note note = results[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${note.subject} - ${note.semester}'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
              );
            },
          ),
        );
      },
    );
  }
}