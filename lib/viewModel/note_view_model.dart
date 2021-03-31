import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/list_note.dart';
import 'package:flutter_app/network/note_service.dart';
import 'package:http/http.dart';

class NoteViewModel {
  Future<ListNote> getListNote(BuildContext context) async {
    ListNote listNote;
    Response resp = await NoteService().getListNote();
    print(resp.statusCode);
    print(resp.body);
    if(resp.statusCode == 200) {
      listNote = ListNote.fromJson(json.decode(resp.body));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error! server return ${resp.statusCode}")));
    }
    return listNote;
  }
  
  void createNote(Note note, BuildContext context, Function update) {
    NoteService().createNote(note).then((value) {
      Response resp = value;
      if(resp.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Create Note Successfully!"),
                duration: Duration(seconds: 1),
            )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error! server return ${resp.statusCode}")));
      }
    });
    update();
  }

  void updateNote(Note note, BuildContext context, Function update) {
    NoteService().updateNote(note).then((value) {
      Response resp = value;
      if(resp.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Update Note Successfully!"),
              duration: Duration(seconds: 1),
            )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error! server return ${resp.statusCode}")));
      }
    });
    update();
  }

  void deleteNote(Note note, BuildContext context, Function update) {
    NoteService().deleteNote(note).then((value) {
      Response resp = value;
      if(resp.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Delete Note Successfully!"),
              duration: Duration(seconds: 1),
            )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error! server return ${resp.statusCode}")));
      }
    });
    update();
  }
}