import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'upload_screen.dart';
import 'note_detail_screen.dart'; // We import the new detail screen here

class NotesScreen extends StatefulWidget {
  final String semester;
  final String subject;

  const NotesScreen({super.key, required this.semester, required this.subject});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Note> filteredNotes = globalNotes
        .where((note) => note.semester == widget.semester && note.subject == widget.subject)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Notes'),
      ),
      body: filteredNotes.isEmpty
          ? const Center(child: Text('No notes found.', style: TextStyle(fontSize: 16)))
          : ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) {
          Note note = filteredNotes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                note.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // truncates long descriptions on the list view
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to the Product Detail page!
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(note: note),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadScreen(
                defaultSemester: widget.semester,
                defaultSubject: widget.subject,
              ),
            ),
          ).then((_) => setState(() {}));
        },
        icon: const Icon(Icons.add),
        label: const Text('Upload'),
      ),
    );
  }
}