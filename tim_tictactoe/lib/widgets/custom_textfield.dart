// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tim_tictactoe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadyOnly;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.isReadyOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blue,
          blurRadius: 5,
          spreadRadius: 0,
        )
      ]),
      child: TextField(
        readOnly: isReadyOnly,
        controller: controller,
        decoration: InputDecoration(
          fillColor: bgColor,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
