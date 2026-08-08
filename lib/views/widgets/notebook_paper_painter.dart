import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class NotebookPaperPainter extends CustomPainter {
  final double lineSpacing;
  final double marginX;

  const NotebookPaperPainter({
    this.lineSpacing = 32.0,
    this.marginX = 80.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Fondo de papel crema
    final Paint bgPaint = Paint()..color = AppColors.bgMain;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Renglones Azules Horizontales
    final Paint linePaint = Paint()
      ..color = AppColors.notebookBlueLine
      ..strokeWidth = 1.0;

    for (double y = lineSpacing; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // 3. Línea de Margen Roja Vertical
    final Paint marginPaint = Paint()
      ..color = AppColors.notebookRedMargin
      ..strokeWidth = 2.0;

    canvas.drawLine(Offset(marginX, 0), Offset(marginX, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant NotebookPaperPainter oldDelegate) => false;
}
