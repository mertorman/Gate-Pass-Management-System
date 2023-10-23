import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/model/stats_model.dart';

class UserStatsModels {
  static final List<StatsModel> userStatsModels = [
    StatsModel(title: "Total Pre Registers", number: "05", color: Colors.green.shade300),
    StatsModel(title: "Total Visitors", number: "05", color: Colors.deepPurple.shade300)
  ];
}
