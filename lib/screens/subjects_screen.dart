import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'notes_screen.dart';

class SubjectsScreen extends StatelessWidget {
  final String semester; // Data passed from HomeScreen

  const SubjectsScreen({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    // Look up the subjects based on the passed semester. If null, return empty list.
    List<String> subjects = subjectsMap[semester] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$semester Subjects'),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          String subject = subjects[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(subject, style: const TextStyle(fontSize: 18)),
              leading: const Icon(Icons.menu_book, color: Colors.blueAccent),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to NotesScreen, passing both semester and subject
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesScreen(
                      semester: semester,
                      subject: subject,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}