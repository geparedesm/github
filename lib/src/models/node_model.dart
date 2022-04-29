import 'package:flutter_application_1/src/models/github_commit/github_commit.dart';

class NodeModel {
  GithubCommit dato;
  NodeModel? izquierda;
  NodeModel? derecha;
  NodeModel? down;

  NodeModel(this.dato);

  NodeModel? insertar(NodeModel? root, NodeModel nuevo) {
    if (root == null) {
      root = nuevo;
    } else if (root.dato.commit?.message == nuevo.dato.commit?.message) {
      root.izquierda = insertar(root.izquierda, nuevo);
    } else {
      root.down = insertar(root.down, nuevo);
    }
    return root;
  }
}
