import 'package:flutter/material.dart';


class StatsModel {
  String? title;
  String? number;
  Color color;
  StatsModel({required this.title, this.number,required this.color});
}

class StatsModels {
  static final List<StatsModel> statsModels = [
    StatsModel(title: "Total Verified Users", number: "05",color: Colors.green.shade300),
    StatsModel(title: "Registration Requests", number: "05",color: Colors.deepPurple.shade300),
    StatsModel(title: "Total Blocked Users", number: "05",color: Colors.deepPurple),
    StatsModel(title: "Total Entries/Exist", number: "05",color: Colors.deepOrange.shade300)
  ];
}
