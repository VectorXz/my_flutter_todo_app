import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/model/list_note.dart';
import 'package:http/http.dart';

class NoteService {
  static String baseUrl() {
    if(Platform.isAndroid) {
      return "http://10.0.2.2:8080";
    } else {
      return "http://localhost:8080";
    }
  }

  Future<Response> getListNote() async {
    Response resp = await post(Uri.parse("${baseUrl()}/list"));
    return resp;
  }

  Future<Response> createNote(Note note) async {
    Response resp = await post(Uri.parse("${baseUrl()}/create"),
    headers: {'Content-Type':'application/json'},
    body: json.encode(note.toJson()));
    return resp;
  }

  Future<Response> updateNote(Note note) async {
    Response resp = await post(Uri.parse("${baseUrl()}/update"),
        headers: {'Content-Type':'application/json'},
        body: json.encode(note.toJson()));
    return resp;
  }

  Future<Response> deleteNote(Note note) async {
    Response resp = await post(Uri.parse("${baseUrl()}/delete"),
        headers: {'Content-Type':'application/json'},
        body: json.encode(note.toJson()));
    return resp;
  }

}