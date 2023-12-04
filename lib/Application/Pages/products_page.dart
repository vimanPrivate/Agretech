import 'dart:convert';
import 'dart:ffi';

import 'package:agretech_app/Application/Pages/Item_insert_page.dart';
import 'package:agretech_app/Business/Models/ProductModel.dart';
import 'package:agretech_app/Business/ProductsService.dart';
import 'package:agretech_app/Data/OfflineDataLayer.dart';
import 'package:agretech_app/Data/Repository/Repository.dart';
import 'package:agretech_app/Application/Widgets/custom_appbar.dart';
import 'package:agretech_app/Application/Widgets/product_container.dart';
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

  Future fetchProducts() async {
    var repository = new Repository();
    var result = await repository.ReadData('Products');
    var offlineStorage = new OfflineDataLayer();

    if(result.isEmpty){
      productList.add(offlineStorage.getStoredValues());
    }else{
      result.forEach((element) {
        setState(() {
          productList.add(element);
        });
      });
    }

    var offline = new OfflineDataLayer();
    offline.storeProductsValues(productList);

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


    //offline.getStoredValues();
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
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder) => ItemInsertPage(itemId: "",)));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
