import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/tree_component.dart';
import 'package:flutter_application_1/src/controllers/home_controller.dart';
import 'package:flutter_application_1/src/models/tree_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  final HomeController _con = HomeController();
  late TreeModelPainter _painter;
  TreeModel objTree = TreeModel();

  @override
  void initState() {
    _getInfo();

    super.initState();

    _painter = TreeModelPainter(objTree);
  }

  void _getInfo() async {
    await _con.getBranches();
    await _con.getCommits();
    setState(() {
      objTree.resetTree();
      for (var item in _con.commitList) {
        objTree.insertarNode(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        key: _con.scaffoldMessengerKey,
        appBar: AppBar(
          title: const Center(child: Text("Gabriel Paredes Task")),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getInfo();
            setState(() {});
          },
          child: const Icon(Icons.update),
        ),
        body: _con.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _con.error != ""
                ? Center(child: Text(_con.error))
                : SingleChildScrollView(child: graphBranchesAndCommits()),
      ),
    );
  }

  Widget graphBranchesAndCommits() {
    return SizedBox(
      height: _con.commitList.length * 50,
      child: CustomPaint(
        painter: _painter,
        size: Size(MediaQuery.of(context).size.width, 250),
      ),
    );
  }
}
