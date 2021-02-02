import 'package:flutter/material.dart';

class kDimension {
  BuildContext context;
  double height;
  double width;
  kDimension(BuildContext context) {
    this.height = MediaQuery.of(context).size.height;
    this.width = MediaQuery.of(context).size.height;
  }

  double kHeight(ratio) {
    return this.height * ratio;
  }

  double kWidth(ratio) {
    return this.width * ratio;
  }
}
