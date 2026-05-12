import 'package:flutter/material.dart';
import '../models/note_model.dart';

  

class NotePages extends StatefulWidget {
  final Note? note;
  const NotePages({super.key, this.note});
  @override
  State<NotePages> createState() => _NotePagesState();
}

class _NotePagesState extends State<NotePages> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      authorController.text = widget.note!.author;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    authorController.dispose();
    super.dispose();
  }

  void saveNote() {
    if (isSaving) return;
    isSaving = true;

    if (!mounted) return;

    if (titleController.text.trim().isEmpty &&
        contentController.text.trim().isEmpty) {
      Navigator.pop(context);
      isSaving = false;
      return;
    }

    final note = Note(
      title: titleController.text,
      content: contentController.text,
      author: authorController.text,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );
    Navigator.pop(context, note);
  }

  void deleteNote() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (confirm == true) {
      Navigator.of(context).pop("delete");
    }
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return PopScope(
      canPop: false,

      onPopInvokedWithResult: (didPop, result) {
        if (didPop || isSaving) return;

        isSaving = true;
        {
          final navigator = Navigator.of(context);

          saveNote();

          navigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: saveNote,
          ),
          actions: [
            IconButton(onPressed: deleteNote, icon: Icon(Icons.delete)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title, content, author
              TextField(
                autofocus: true,
                controller: titleController,
                style: Theme.of(context).textTheme.titleLarge,
                decoration: const InputDecoration(
                  hint: Text("judul"),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: TextField(
                  controller: contentController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hint: Text("isi"),
                  ),
                ),
              ),

              Divider(color: Theme.of(context).colorScheme.primary),


              SizedBox(height: 12),


              TextField(
                controller: authorController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hint: Text("ditulis oleh"),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
