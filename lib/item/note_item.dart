import 'package:flutter/material.dart';
import 'package:flutter_app/model/list_note.dart';

class NoteItem extends StatelessWidget {

  Note note;
  Function edit;
  Function delete;

  NoteItem({@required note, @required edit, @required delete}) {
    this.note = note;
    this.edit = edit;
    this.delete = delete;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        title: Text(note.noted, style: TextStyle(color: Colors.white)),
        subtitle: Text(DateTime.fromMillisecondsSinceEpoch(note.updateDtm * 1000).toString(), style: TextStyle(color: Colors.white),),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit, color: Colors.white), onPressed: (){
              print("Edit clicked");
              edit(note);
            },),
            IconButton(icon: Icon(Icons.delete, color: Colors.white), onPressed: (){
              print("Delete clicked");
              delete(note);
            },)
          ],
        ),
      ),
    );
  }
}
