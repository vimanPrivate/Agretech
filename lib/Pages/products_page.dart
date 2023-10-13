//import 'dart:html';

import 'dart:convert';
import 'dart:ffi';

import 'package:agretech_app/Pages/Item_insert_page.dart';
import 'package:agretech_app/Widgets/custom_appbar.dart';
import 'package:agretech_app/Widgets/product_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic> productList = [];
  final _localCache = Hive.box('localCache');

  Future fetchProducts() async {
    await FirebaseFirestore.instance.collection("Products").get().then(
            (snapshot) => snapshot.docs.forEach(
                (document) {
              setState(() {
                productList.add(document);
              });
              //print(productList);
            })
    );
  }

  void editProduct(e) {
    Navigator.push(context, MaterialPageRoute(builder: (builder) => ItemInsertPage(itemId: e,)));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      fetchProducts();
    });

    _localCache.put(1, "{name:'Viman',age:28}");
    _localCache.put(2, "bla ba bla");

    print(_localCache.get(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Products",
          backgroundImage: "",
        ),
        body: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (val,index){
            return  ProductContainer(
                productName: productList[index].data()["itemName"],
                unit: productList[index].data()["unit"],
                price: productList[index].data()["price"],
                owner: productList[index].data()["addedBy"],
                function: () => editProduct(productList[index].reference.id),
            );
          },
        )
    );
  }
}
