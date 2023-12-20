import 'dart:convert';

class GateAccessModel {
  final String? userId;
  final String? username;
  final List<Entry>? entries;
  final bool? isInside;
  final String? id;
  final int? v;
  final String? lastEntry;
  final String? lastExit;

  GateAccessModel({
    this.userId,
    this.username,
    this.entries,
    this.isInside,
    this.id,
    this.v,
    this.lastEntry,
    this.lastExit,
  });

  factory GateAccessModel.fromInfo(Map<String, dynamic> json) {
    return GateAccessModel(
      userId: json['access']['userId'],
      username: json['access']['username'],
      entries: (json['access']['entries'] as List<dynamic>?)
          ?.map((entry) => Entry.fromJson(entry))
          .toList(),
      isInside: json['access']['isInside'],
      id: json['access']['_id'],
      v: json['access']['__v'],
      lastEntry: json['lastEntry'],
      lastExit: json['lastExit'],
    );
  }

  factory GateAccessModel.fromAllInfo(Map<String, dynamic> json) {


    return GateAccessModel(
      id: json['_id'],
      userId: json['userId'],
      username: json['username'],
      entries: List<Entry>.from(json["entries"].map((entry) => Entry.fromJson(entry))),
      isInside: json['isInside'],
    );
  }

  /* static List<GateAccessModel> userListFromJson(Map<String, dynamic> jsonString) {
    List<Map<String, dynamic>> jsonDataList = jsonString;
    return jsonDataList
        .map((user) => GateAccessModel.fromAllInfo(user))
        .toList();
  }*/

  factory GateAccessModel.fromAccess(Map<String, dynamic> json) {
    return GateAccessModel(
      userId: json['userId'],
      username: json['username'],
      entries: (json['entries'] as List<dynamic>)
          .map((entry) => Entry.fromJson(entry))
          .toList(),
      isInside: json['isInside'],
      id: json['_id'],
      v: json['__v'],
      lastEntry: json['lastEntry'],
      lastExit: json['lastExit'],
    );
  }
}

class Entry {
  final String? entryDate;
  final String? entryTime;
  final String? exitDate;
  final String? exitTime;

  Entry({
    this.entryDate,
    this.entryTime,
    this.exitDate,
    this.exitTime,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      entryDate: json['entryDate'],
      entryTime: json['entryTime'],
      exitDate: json['exitDate'],
      exitTime: json['exitTime'],
    );
  }
}
