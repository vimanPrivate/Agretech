import 'package:agretech_app/Widgets/custom_appbar.dart';
import 'package:agretech_app/Widgets/dropdown_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widgets/textbox_product_widget.dart';
import '../Widgets/textbox_widget.dart';

class ItemInsertPage extends StatefulWidget {
  final String itemId ;
  const ItemInsertPage({required this.itemId});

  @override
  State<ItemInsertPage> createState() => _ItemInsertPageState();
}

class _ItemInsertPageState extends State<ItemInsertPage> {
  final List<String> list = <String>['Product', 'Tool','Something'];
  final List<String> siUnit = <String>['Kg', 'g','l','ml'];

  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  bool testVar = true;
  String btnText = "";

  String selectedItemType = "";
  String getSelectedItemTypeVal(e){
    setState(() {
      selectedItemType = e;
    });
    return "";
  }

  String selectedSiUnit = "";
  String getSelectedSiUnitVal(e){
    setState(() {
      selectedSiUnit = e;
    });
    return "";
  }

  void addProduct(){
    FirebaseFirestore.instance.collection('Products').add({
      'itemName': _itemController.text,
      'price':_priceController.text,
      'quantity':_quantityController.text,
      'unit':selectedSiUnit,
      'type':selectedItemType,
      'addedBy':'test'
    });
  }

  List<dynamic> productList = [];

  void getProductList() async{
    await FirebaseFirestore.instance.collection("Products").get().then(
            (snapshot) => snapshot.docs.forEach(
                    (document) {
                        setState(() {
                          productList.add(document);
                        });
                        //print(productList);
                    })
    );

    String key = widget.itemId ;

    if(key != ""){
      for(var itm in productList){
        if(key == itm.reference.id){
          _itemController.text = itm.data()["itemName"];
          _priceController.text = itm.data()["price"];
          _quantityController.text =  itm.data()["quantity"];
        }
      }
    }
  }

  Widget renderSom(){
    return ElevatedButton(onPressed: (){}, child: Text("Rendering buttion"));
  }

  @override
  void initState() {
    getProductList();
    if(widget.itemId.length == 0){
      btnText = "Add Product";
    }else{
      btnText = "Update";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Item',
        backgroundImage: "",
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextboxProductWidget(controller: _itemController,hint: "Item Name",),
            SizedBox(height: 20,),
            TextboxProductWidget(controller: _priceController,hint: "Price",),
            SizedBox(height: 20,),
            TextboxProductWidget(controller: _quantityController,hint: "Quantity",),
            SizedBox(height: 20,),
            DropdownWidget(list: siUnit,func: getSelectedSiUnitVal,),
            SizedBox(height: 20,),
            DropdownWidget(list: list,func: getSelectedItemTypeVal,),
            ElevatedButton(
              onPressed: () => addProduct(),
              child: Text(btnText)
            ),
            testVar? renderSom():Text("nothing"),
          ],
        ),
      ),
    );
  }
}
