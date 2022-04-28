import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controllers/home_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  final HomeController _con = HomeController();
  @override
  void initState() {
    _con.getBranches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        key: _con.scaffoldMessengerKey,
        appBar: AppBar(
          title: const Text("Hola"),
        ),
        body: MaterialButton(onPressed: () async {}, child: const Text("Hola")),
      ),
    );
  }
}
