import 'package:flutter/material.dart';

class CommonSizeBoxWidget extends StatelessWidget {
  double? width;
  double? height;
  Widget? widget;

  CommonSizeBoxWidget({this.width, this.height, this.widget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: widget,
    );
  }
}
