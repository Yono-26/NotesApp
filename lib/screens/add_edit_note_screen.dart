import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/notes_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final bool isEdit;
  final NotesModel? note;
  final int? index;

  const AddEditNoteScreen({
    super.key,
    required this.isEdit,
    this.note,
    this.index,
  });

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final Box<NotesModel> notesBox = Hive.box<NotesModel>('notesBox');

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final note = NotesModel(
      title: title,
      content: content,
      date: DateTime.now(),
    );

    if (widget.isEdit && widget.index != null) {
      notesBox.putAt(widget.index!, note);
    } else {
      notesBox.add(note);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 6,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text(widget.isEdit ? 'Update' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
