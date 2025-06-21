import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/notes_model.dart';
import 'add_edit_note_screen.dart';

class HomePage extends StatelessWidget {
  final Box<NotesModel> notesBox = Hive.box<NotesModel>('notesBox');

  void _deleteNote(BuildContext context ,int index) {


    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Are you sure you want to delete this Note ?'),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),

          TextButton(onPressed: (){
            notesBox.deleteAt(index);
            Navigator.pop(context);
          }, child: Text('Delete'))
        ],
      );
    },);
  }

  void editNote(BuildContext context, NotesModel note, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEditNoteScreen(isEdit: true, note: note, index: index),
      ),
    );
  }

  void addNote(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditNoteScreen(isEdit: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Notes')),
      body: ValueListenableBuilder(
        valueListenable: notesBox.listenable(),
        builder: (context, Box<NotesModel> box, _) {
          if (box.isEmpty) {
            return Center(child: Text("No notes yet!"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final note = box.getAt(index);
              return ListTile(
                title: Text(note!.title),
                subtitle: Text(note.content),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue,),
                      onPressed: () => editNote(context, note, index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => _deleteNote(context,index),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () => addNote(context),
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
