import 'dart:core';

import 'package:flutter/material.dart';

class CommonContainerWidget extends StatelessWidget {
  Color? color;
  Color? colorFont;
  double? fontSize;

  double? height;
  double? width;
  void Function()? onPressed;
  String? title;

  CommonContainerWidget({
    this.color,
    this.height,
    this.width,
    this.onPressed,
    this.title,
    this.colorFont,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          '$title',
          style: TextStyle(
            color: colorFont,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
