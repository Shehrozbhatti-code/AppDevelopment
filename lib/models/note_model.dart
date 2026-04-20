class Note {
  final String title;
  final String description;
  final String semester;
  final String subject;
  final String author;

  Note({
    required this.title,
    required this.description,
    required this.semester,
    required this.subject,
    this.author = "Anonymous Student",
  });
}

// In-memory database
List<Note> globalNotes = [
  Note(
    title: "Calculus Limits Basics",
    description: "Introduction to limits, derivatives, and basic formulas. Make sure to memorize the standard limits for the midterm.",
    semester: "Semester 1",
    subject: "Math",
    author: "Shehroz",
  ),
  Note(
    title: "Newton's Laws",
    description: "Summary of the three laws of motion with examples. Includes free-body diagrams.",
    semester: "Semester 1",
    subject: "Physics",
    author: "Bhatti",
  ),
];

const List<String> semestersList = ["Semester 1", "Semester 2", "Semester 3"];

const Map<String, List<String>> subjectsMap = {
  "Semester 1": ["Math", "Physics", "CS"],
  "Semester 2": ["Data Structures", "Electronics", "English"],
  "Semester 3": ["Algorithms", "Database Systems", "Operating Systems"],
};