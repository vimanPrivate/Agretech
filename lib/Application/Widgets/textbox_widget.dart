import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextboxWidget extends StatelessWidget {
  TextEditingController controller;
  String hint ;
  Icon icon ;
  bool isPassword ;
  TextboxWidget({required this.controller,required this.hint,required this.isPassword,required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:isPassword,
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          contentPadding:EdgeInsets.all(17),
        //icon: Icon(Icons.email)
        prefixIcon: icon //Icon(Icons.email)
      ),
    );
  }
}

