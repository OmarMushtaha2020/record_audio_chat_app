import 'package:flutter/material.dart';

class CommonTextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Color? color;

  CommonTextFormFieldWidget({
    this.controller,
    this.labelText,
    this.fontSize,
    this.fontWeight,
    this.validator,
    this.keyboardType,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType, // Use the keyboardType here
      decoration: InputDecoration(
        labelText: labelText, // Use the labelText parameter here
        labelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
