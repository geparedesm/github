import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/node_model.dart';
import 'package:flutter_application_1/src/models/tree_model.dart';

class TreeModelPainter extends CustomPainter {
  TreeModel objTreeModel = TreeModel();
  static const double diameter = 10;
  static const double radio = diameter / 2;
  static const int ancho = 20;

  TreeModelPainter(TreeModel obj) {
    objTreeModel = obj;
  }
  @override
  void paint(Canvas canvas, Size size) {
    pintar(canvas, size.width / 6, 20, objTreeModel.root);
  }

  @override
  bool shouldRepaint(TreeModelPainter oldDelegate) => true;
  final colorList = [
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.deepOrange
  ];
  void pintar(Canvas canvas, double x, double y, NodeModel? n) {
    Paint brushCirculoBorde = Paint()
      ..color = const Color(0xff278ea5)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Paint brushCirculo = Paint()
      ..color = colorList[n?.dato.commit?.color ?? 0]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Paint brushLinea = Paint()
      ..color = const Color(0xff278ea5)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;

    const textStyle = TextStyle(
      color: Color(0xff1f4287),
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: n?.izquierda != null
          ? "The ${n?.dato.commit?.branch} branch was created"
          : n?.dato.commit?.message,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: x,
      maxWidth: double.infinity,
    );

    final offsetText = Offset(x + 20, y - 6);
    if (n != null) {
      double extra = objTreeModel.height(n) * (ancho / 2);
      if (n.izquierda != null) {
        canvas.drawLine(
            Offset(x + radio, y - radio),
            Offset(x - ancho - extra + radio, y + (ancho + radio) * 2),
            brushLinea);
      }
      if (n.derecha != null) {
        canvas.drawLine(Offset(x + radio, y + radio * 0.2),
            Offset(x + ancho + extra + radio, y + ancho + radio), brushLinea);
      }
      if (n.down != null) {
        canvas.drawLine(
            Offset(x, y + 10), Offset(x, y + (ancho + radio) * 2), brushLinea);
      }

      canvas.drawCircle(Offset(x, y), diameter, brushCirculo);
      canvas.drawCircle(Offset(x, y), diameter, brushCirculoBorde);
      textPainter.paint(canvas, offsetText);
      if (n.izquierda != null) {
        pintar(
            canvas, x - ancho - extra, y + (ancho + radio) * 2, n.izquierda!);
      }
      if (n.derecha != null) {
        pintar(canvas, x + ancho + extra, y + ancho, n.derecha!);
      }
      if (n.down != null) {
        pintar(canvas, x, y + (ancho + radio) * 2, n.down!);
      }
    }
  }
}
