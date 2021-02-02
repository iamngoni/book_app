import 'package:flutter/material.dart';

customIcon({
  @required String path,
  @required double size,
  Color color = Colors.grey,
}) {
  return Image.asset(path, color: color, height: size, width: size);
}
