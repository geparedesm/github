import 'dart:math' show max;

import 'package:flutter_application_1/src/models/github_commit/github_commit.dart';
import 'package:flutter_application_1/src/models/node_model.dart';

class TreeModel {
  NodeModel? root;

  void insertarNode(GithubCommit elemento) {
    NodeModel nuevo = NodeModel(elemento);
    root = nuevo.insertar(root, nuevo)!;
  }

  int height(NodeModel n) {
    int altR = (n.derecha == null ? 0 : 1 + height(n.derecha!));
    int altL = (n.izquierda == null ? 0 : 1 + height(n.izquierda!));
    int altD = (n.down == null ? 0 : 1 + height(n.down!));
    final alt1 = max(altR, altL);
    return max(alt1, altD);
  }

  void resetTree() {
    root = null;
  }
}
