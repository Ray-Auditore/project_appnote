import 'package:flutter/material.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/pages/note_pages.dart';
import 'package:noteapp/services/database_helper.dart';
import 'package:noteapp/widget/note_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  // LOAD NOTES
  Future<void> loadNotes() async {
    final data = await DatabaseHelper.instance.getNotes();

    setState(() {
      notes = data;
    });
  }

  // ADD
  void addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  // UPDATE
  void updateNote(int index, Note note) {
    setState(() {
      notes[index] = note;
    });
  }

  // DELETE
  Future<void> deleteNote(int index) async {
    final confirm = await showConfirmDialog(context);

    if (!confirm) return;

    await DatabaseHelper.instance.deleteNote(notes[index].id!);

    await loadNotes();
  }

  // DIALOG CONFIRM
  Future<bool> showConfirmDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Hapus Note"),
            content: const Text("Yakin mau hapus?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Hapus"),
              ),
            ],
          ),
        ) ??
        false;
  }

  // NAVIGATION
  void goToNotePage({Note? note, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NotePages(note: note)),
    );

    // DELETE
    if (result == "delete" && index != null) {
      await DatabaseHelper.instance.deleteNote(notes[index].id!);

      await loadNotes();
    }
    // UPDATE
    else if (result is Note && index != null) {
      await DatabaseHelper.instance.updateNote(result);

      await loadNotes();
    }
    // ADD
    else if (result is Note) {
      await DatabaseHelper.instance.insertNote(result);

      await loadNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToNotePage();
        },
        child: const Icon(Icons.add),
      ),

      body: notes.isEmpty
          ? Center(
              child: Text(
                "Belum ada catatan",
                style: theme.textTheme.bodyMedium,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return NoteCard(
                  note: notes[index],

                  onEdit: () => goToNotePage(note: notes[index], index: index),
                  onDelete: () => goToNotePage(note: notes[index]),
                );
              },
            ),
    );
  }
}
