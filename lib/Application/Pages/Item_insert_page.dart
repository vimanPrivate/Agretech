import 'package:agretech_app/Application/Pages/login_page.dart';
import 'package:agretech_app/Application/Widgets/custom_appbar.dart';
import 'package:agretech_app/Application/Widgets/dropdown_widget.dart';
import 'package:agretech_app/Business/Models/ProductModel.dart';
import 'package:agretech_app/Business/ProductsService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../Utils/globals.dart' as globals;

import '../Widgets/main_button_widget.dart';
import '../Widgets/textbox_product_widget.dart';
import '../Widgets/textbox_widget.dart';

class ItemInsertPage extends StatefulWidget {
  final String itemId ;
  const ItemInsertPage({required this.itemId});

  @override
  State<ItemInsertPage> createState() => _ItemInsertPageState();
}

class _ItemInsertPageState extends State<ItemInsertPage> {
  final List<String> list = <String>['Product', 'Tool'];
  final List<String> siUnit = <String>['Kg', 'g','l','ml'];

  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  bool testVar = true;
  String btnText = "";
  String heddingText = "";

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
    var model = new ProductModel();

    model.name = _itemController.text;
    model.price = _priceController.text;
    model.owner = globals.userId;
    model.unit = selectedSiUnit;
    model.type = selectedItemType;
    model.quantity = int.parse(_quantityController.text);

    var prdService = new ProductsService();
    var result = prdService.AddProducts(model);
    QuickAlert.show(context: context, type: QuickAlertType.success);

    _itemController.text = "";
    _priceController.text = "";
    _quantityController.text = "";
    //_itemController.text = "";
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

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(globals.isLoggedIn == false){
        Navigator.push(context, MaterialPageRoute(builder: (builder) => LoginPage()));
      }
      getProductList();
    });

    if(widget.itemId.length == 0){
      btnText = "Add Product";
      heddingText = "Add";
    }else{
      btnText = "Update";
      heddingText = "Update";
    }
  }

  @override
  Widget build(BuildContext context) {
    String headingFontFamily = 'BerkshireSwash';
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Item',
        backgroundImage: "",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text(
                heddingText +" your products here!",
                style: TextStyle(fontSize: 38, fontFamily: headingFontFamily),
              ),
              SizedBox(height: 50,),
              TextboxProductWidget(controller: _itemController,hint: "Item Name",),
              SizedBox(height: 20,),
              TextboxProductWidget(controller: _priceController,hint: "Price",),
              SizedBox(height: 20,),
              TextboxProductWidget(controller: _quantityController,hint: "Quantity",),
              SizedBox(height: 20,),
              DropdownWidget(list: siUnit,func: getSelectedSiUnitVal,),
              SizedBox(height: 20,),
              DropdownWidget(list: list,func: getSelectedItemTypeVal,),
              SizedBox(height: 40,),
              MainButtonWidget(title: btnText ,onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (builder) => SignupPage()));
                addProduct();
              },width: 350,),
              // ElevatedButton(
              //   onPressed: () => addProduct(),
              //   child: Text(btnText)
              // ),
              //testVar? renderSom():Text("nothing"),
            ],
          ),
        ),
      ),
    );
  }
}
