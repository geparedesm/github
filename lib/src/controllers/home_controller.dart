import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/branches_models.dart';
import 'package:flutter_application_1/src/models/github_commit/github_commit.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import '../services/home_services.dart' as services;

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  List<BranchesModel> branchesList = [];
  List<List<GithubCommit>> commitListList = [];
  List<GithubCommit> commitList = [];
  bool isLoading = false;
  String error = "";
  getBranches() async {
    isLoading = true;
    branchesList = [];
    final response = await services.getBranches();
    if (response.statusCode == 200) {
      List bodyTemp = jsonDecode(response.body);
      for (var item in bodyTemp) {
        branchesList.add(BranchesModel.fromJson(item));
      }
      List<BranchesModel> branchesListTemp = [];
      if (branchesList.length > 2) {
        branchesListTemp = [branchesList[1], branchesList[0], branchesList[2]];
      }
      branchesList = branchesListTemp;
    } else {
      final errorTemp = jsonDecode(response.body);

      error =
          'Failed to load branches \nError:${response.statusCode} \n${errorTemp['message']}}';
    }

    isLoading = false;
  }

  getCommits() async {
    commitList = [];
    isLoading = true;
    for (var itemBranch in branchesList) {
      final response = await services.getCommits(100, itemBranch.name);
      if (response.statusCode == 200) {
        List bodyTemp = jsonDecode(response.body);
        for (var itemCommit in bodyTemp) {
          final index = branchesList.indexOf(itemBranch);
          commitList.add(GithubCommit.fromJson(itemCommit,
              {"branchName": itemBranch.name, "branchIndex": index}));
        }
      } else {
        error = 'Failed to load commits \nError:${response.statusCode}';
      }
    }
    commitList.sort((a, b) => a.commit!.committer!.date!
        .compareTo(b.commit!.committer!.date as DateTime));

    isLoading = false;

    List<GithubCommit> tempCommitList = [];
    List<String> tempBranchesList = [];
    for (var item in commitList) {
      if (!tempCommitList.contains(item) ||
          !tempBranchesList.contains(item.commit?.branch)) {
        if (!tempBranchesList.contains(item.commit?.branch) &&
            tempCommitList.contains(item)) {
          tempBranchesList.add(item.commit?.branch ?? '');
        }
        tempCommitList.add(item);
      }
    }
    commitList = tempCommitList;
  }
}
