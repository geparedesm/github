import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/branches_models.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../services/home_services.dart' as services;

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  List<BranchesModel> branchesList = [];
  getBranches() async {
    final response = await services.getBranches();
    if (response.statusCode == 200) {
      List bodyTemp = jsonDecode(response.body);
      for (var item in bodyTemp) {
        branchesList.add(BranchesModel.fromJson(item));
      }
    } else {
      throw Exception('Failed to load branches');
    }
    // return (x + '2');
  }
}
