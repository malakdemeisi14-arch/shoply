import 'package:flutter/material.dart';

String money(double v) =>
    '\$${v.toStringAsFixed(v == v.roundToDouble() ? 0 : 2)}';

void showMsg(BuildContext context, String msg) {
  final m = ScaffoldMessenger.of(context);
  m.hideCurrentSnackBar();
  m.showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
}
