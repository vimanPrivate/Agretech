import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({required this.title,required this.onPressed,required this.width});
  final String title ;
  final dynamic onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == 0? double.infinity: width,
      height: 50,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(28, 51, 3, 1)
            ),
            shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(30)
                )
            )
        ),
      ),
    );
  }
}
