import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Utils/globals.dart' as globals;

class ProductContainer extends StatelessWidget {
  final String productName;
  final String unit;
  final String price;
  final String owner;
  final dynamic function;

  const ProductContainer(

      {required this.productName,
      required this.unit,
      required this.price,
      required this.owner,
      required this.function}

      );


  @override
  Widget build(BuildContext context) {
    bool allowEdit = false;
    if(owner == globals.userId){
      allowEdit = true;
    }
    return Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            //color: Colors.red,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            // height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                productName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'AlbertSans',
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "1 " + unit,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Text(
                              price + " LKR",
                              style: TextStyle(
                                  fontSize: 14,
                                  //fontFamily: 'Aleo',
                                  fontFamily: 'AlbertSans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                owner,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'AlbertSans',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      // Right Pannel -------------------------------------------------
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(55, 135, 5, 1),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                            child: Text(
                              "5 likes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            //width: 18.0,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Visibility(
                              visible: allowEdit,
                              child: IconButton(
                                onPressed: function,
                                icon: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
