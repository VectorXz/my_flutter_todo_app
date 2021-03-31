import 'package:flutter/material.dart';
import 'package:flutter_app/model/list_note.dart';
import 'package:flutter_app/viewModel/note_view_model.dart';
import 'package:flutter_app/item/note_item.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Note lists")),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ListNote listNote = snapshot.data;
            return listNote.notes.isEmpty
                ? Center(child: Text("No data received!"))
                : ListView.builder(
                    itemBuilder: (context, position) {
                      return NoteItem(note: listNote.notes[position], edit: showEditDialog, delete: showDeleteDialog);
                    },
                    itemCount: listNote.notes.length,
                  );
          } else {
            return CircularProgressIndicator();
          }
        },
        future: NoteViewModel().getListNote(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  TextEditingController textNote = TextEditingController();

  void showAddDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            content: Container(
                width: double.maxFinite,
                child: TextField(
                  controller: textNote,
                  decoration: InputDecoration(labelText: "Enter note"),
                )
            ),
          actions: [TextButton(onPressed: () {
            print("add");
            Note note = Note(noted: textNote.text);
            NoteViewModel().createNote(note, context, updateList);
            Navigator.pop(context);
          }, child: Text("ADD"),),
            TextButton(onPressed: () {
              print("cancel");
              Navigator.pop(context);
              textNote.clear();
            }, child: Text("CANCEL"),)]
        )
    );
  }

  void updateList() {
    setState(() {
      textNote.clear();
    });
  }

  void showEditDialog(Note note) {
    textNote.text = note.noted;
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            content: Container(
                width: double.maxFinite,
                child: TextField(
                  controller: textNote,
                  decoration: InputDecoration(labelText: "Enter note"),
                )
            ),
            actions: [TextButton(onPressed: () {
              print("save");
              note.setNoted(textNote.text);
              note.setTime(DateTime.now().millisecondsSinceEpoch);
              NoteViewModel().updateNote(note, context, updateList);
              Navigator.pop(context);
            }, child: Text("SAVE"),),
              TextButton(onPressed: () {
                print("cancel");
                Navigator.pop(context);
                textNote.clear();
              }, child: Text("CANCEL"),)]
        )
    );
  }

  void showDeleteDialog(Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: double.maxFinite,
          child: Text("Are you sure?")
        ),
        actions: [
          TextButton(
          onPressed: () {
            print("YES");
            NoteViewModel().deleteNote(note, context, updateList);
            Navigator.pop(context);
          },
          child: Text("YES"),
        ),
          TextButton(
            onPressed: () {
              print("NO");
              Navigator.pop(context);
            },
            child: Text("NO"),
          )],
      )
    );
  }
}
