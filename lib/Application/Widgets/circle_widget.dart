import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleBox extends StatefulWidget {
  final String title ;
  final String subTitle ;
  final String assetImage;

  const CircleBox({required this.title,required this.subTitle, required this.assetImage});

  @override
  State<CircleBox> createState() => _CircleBoxState();
}

class _CircleBoxState extends State<CircleBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("clicked ---------->");
      },
      child: Column(
        children: [
          Container(
            width: 150,
            margin: EdgeInsets.fromLTRB(33, 15, 0, 15),
            height: 150,
            decoration: BoxDecoration(
              //border: Border.all(),
                borderRadius: BorderRadius.circular(00),
                image: DecorationImage(
                    image: AssetImage(
                        widget.assetImage),
                    fit: BoxFit.cover)),
            child: Text('')
          ),
          Text(widget.title,style: TextStyle(fontSize: 25,color: Colors.black),),
          Text(widget.subTitle,style: TextStyle(fontSize: 15,color: Colors.black),),
        ],
      ),
    );
  }
}
