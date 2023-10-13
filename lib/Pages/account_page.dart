import 'dart:io';

import 'package:agretech_app/Widgets/custom_appbar.dart';
import 'package:agretech_app/Widgets/main_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/product_container.dart';
import '../Widgets/textbox_widget.dart';
import 'Item_insert_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _emailOrPnController = TextEditingController();
  final _organizationController = TextEditingController();
  final _passwordPnController = TextEditingController();
  final _rePasswordController = TextEditingController();

  String emailOrPw = "";
  String organization = "";
  String password = "";
  String rePassword = "";

  List<dynamic> productList = [];

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
    print(productList);
  }

  void UpdateAccount(){
    emailOrPw = _emailOrPnController.text;
    organization = _organizationController.text;
    password = _passwordPnController.text;
    rePassword = _rePasswordController.text;

    FirebaseFirestore.instance.collection('Accounts').add({
      'emailOrPhone':emailOrPw,
      'organization':organization,
      'password':password
    });
  }

  void textFunc(){

  }

  Widget renderProducts(){
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: productList.length,
        itemBuilder: (val,index){
          return  ProductContainer(
            productName: productList[index].data()["itemName"],
            unit: productList[index].data()["unit"],
            price: productList[index].data()["price"],
            owner: productList[index].data()["addedBy"],
            function: () => editProduct(productList[index].reference.id),
          );////Text(productList[index].reference.id);//ProductContainer(productName: _list[index],);
        },
      ),
    );
  }

  String imageUrl = "";
  String capturedImage = "";
  XFile? file;

  Future AddImage() async{
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.camera);
    capturedImage = '${file?.path}';

    if(file == null) return ;

    Reference refRoot = FirebaseStorage.instance.ref();
    Reference refDirImage = refRoot.child('images');

    Reference refToImageUpload = refDirImage.child(DateTime.now().microsecondsSinceEpoch.toString());

    await refToImageUpload.putFile(File(file!.path));
    imageUrl = await refToImageUpload.getDownloadURL();
    print("---------------- 5 ------------ >"+imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: "Account",
      //   backgroundImage: "Assets/Images/shutterstock_1450482422.jpg",
      // ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Profile"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ScaffoldMessenger(child: Text("heyyy")),
              SizedBox(height: 25,),
              // Image(
              //   //image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/agretech-6d964.appspot.com/o/images%2F1696169050045300?alt=media&token=5204cadc-88af-4203-b2ff-e829dbb3ef89'),
              // ),
              // Image.file(File('${file?.path}')),
              IconButton(
                  onPressed: ()=> AddImage(),
                  icon: Icon(Icons.camera)
              ),
              SizedBox(height: 25,),
              Text(
                  "Hello!",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: ""
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text("Created Date : "),
                    Text("2023-10-01"),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              TextboxWidget(controller: _emailOrPnController,hint: "Email / Phone No",icon: Icon(Icons.email),),
              SizedBox(height: 15,),
              TextboxWidget(controller: _emailOrPnController,hint: "Search",icon: Icon(Icons.search),),
              SizedBox(height: 15,),
              TextboxWidget(controller: _organizationController,hint: "Organization(Optional)",icon: Icon(Icons.person)),
              SizedBox(height: 15,),
              TextboxWidget(controller: _passwordPnController,hint: "Password",icon: Icon(Icons.key)),
              SizedBox(height: 15,),
              TextboxWidget(controller: _rePasswordController,hint: "Re-Enter Password",icon: Icon(Icons.key)),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MainButtonWidget(title: "Update Account",onPressed: textFunc,width: 200,)
                ],
              ),
              SizedBox(height: 30,),
              Text(
                "Products",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "",
                    fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30,),
              productList == []?Text("Empty"):renderProducts()
            ],
          ),
        ),
      ),
    );
  }
}
