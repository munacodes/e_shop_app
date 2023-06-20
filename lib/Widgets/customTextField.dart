import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.data,
      required this.hintText,
      required this.isObsecure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
