import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsModel {
  String? title;
  String? number;
  Color color;
  StatsModel({required this.title, required this.number,required this.color});
}

class StatsModels extends GetxController {
  static final List<StatsModel> statsModels = [
    StatsModel(title: "Total Employess", number: "05",color: Colors.green.shade300),
    StatsModel(title: "Total Visitors", number: "05",color: Colors.deepPurple.shade300),
    StatsModel(title: "Total Pre Registers", number: "05",color: Colors.deepPurple),
    StatsModel(title: "Today's Check in", number: "05",color: Colors.deepOrange.shade300)
  ];
}
