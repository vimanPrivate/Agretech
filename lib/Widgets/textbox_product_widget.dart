import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextboxProductWidget extends StatelessWidget {
  TextEditingController controller;
  String hint ;
  TextboxProductWidget({required this.controller,required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          contentPadding:EdgeInsets.all(17)
      ),
    );
  }
}
