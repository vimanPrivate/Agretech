import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMainButton extends StatefulWidget {
  final String title ;
  final String subTitle ;
  final String assetImage;
  const HomeMainButton({required this.title,required this.subTitle, required this.assetImage});

  @override
  State<HomeMainButton> createState() => _HomeMainButtonState();
}

class _HomeMainButtonState extends State<HomeMainButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("clicked ---------->");
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
        height: 170,
        decoration: BoxDecoration(
            //border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(
                    widget.assetImage),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.white),
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,style: TextStyle(fontSize: 25,color: Colors.white),),
                  Text(widget.subTitle,style: TextStyle(fontSize: 15,color: Colors.white),),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
