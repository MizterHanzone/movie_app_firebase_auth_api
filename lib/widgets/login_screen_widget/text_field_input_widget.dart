import 'package:flutter/material.dart';
import 'package:project_assignment/themes/theme.dart';

class TextFieldInputWidget extends StatelessWidget {

  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;

  const TextFieldInputWidget({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPass,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        prefixIcon:  Icon(icon),
      ),
    );

  }
}
