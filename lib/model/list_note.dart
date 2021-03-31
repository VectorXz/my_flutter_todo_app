/// notes : [{"id":"","noted":"","createBy":"","createDtm":0,"updateDtm":0}]

class ListNote {
  List<Note> _notes;

  List<Note> get notes => _notes;

  ListNote({
      List<Note> notes}){
    _notes = notes;
}

  ListNote.fromJson(dynamic json) {
    if (json["notes"] != null) {
      _notes = [];
      json["notes"].forEach((v) {
        _notes.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_notes != null) {
      map["notes"] = _notes.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : ""
/// noted : ""
/// createBy : ""
/// createDtm : 0
/// updateDtm : 0

class Note {
  String _id;
  String _noted;
  String _createBy;
  int _createDtm;
  int _updateDtm;

  String get id => _id;
  String get noted => _noted;
  String get createBy => _createBy;
  int get createDtm => _createDtm;
  int get updateDtm => _updateDtm;

  Note({
      String id, 
      String noted, 
      String createBy, 
      int createDtm, 
      int updateDtm}){
    _id = id;
    _noted = noted;
    _createBy = createBy;
    _createDtm = createDtm;
    _updateDtm = updateDtm;
}

  Note.fromJson(dynamic json) {
    _id = json["id"];
    _noted = json["noted"];
    _createBy = json["createBy"];
    _createDtm = json["createDtm"];
    _updateDtm = json["updateDtm"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["noted"] = _noted;
    map["createBy"] = _createBy;
    map["createDtm"] = _createDtm;
    map["updateDtm"] = _updateDtm;
    return map;
  }

  void setNoted(String text) {
    _noted = text;
  }

  void setTime(int timestamp) {
    _updateDtm = timestamp;
  }

}