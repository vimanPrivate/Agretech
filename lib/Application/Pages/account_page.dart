import 'dart:io';

import 'package:agretech_app/Application/Widgets/custom_appbar.dart';
import 'package:agretech_app/Application/Widgets/main_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../Utils/globals.dart' as globals;
import '../Widgets/product_container.dart';
import '../Widgets/textbox_widget.dart';
import 'Item_insert_page.dart';
import 'login_page.dart';

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
  String accId = "";
  String uploadedImage = "https://simpleicon.com/wp-content/uploads/account.png";

  Future fetchProducts() async {
    await FirebaseFirestore.instance
        .collection("Products")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              var addedBy = document.data()["addedBy"];
              if (globals.userId == addedBy) {
                setState(() {
                  productList.add(document);
                });
              }
            }));
  }

  Future fetchAccount() async {
    await FirebaseFirestore.instance
        .collection("Accounts")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              var aId = document.data()["emailOrPhone"];
              if (globals.userId == aId) {
                _emailOrPnController.text = aId;
                setState(() {
                  accId = aId;
                });
              }
            }));
  }

  void editProduct(e) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => ItemInsertPage(
                  itemId: e,
                )));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (globals.isLoggedIn == false) {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => LoginPage()));
      }
      fetchProducts();
      fetchAccount();
    });
    print(productList);
  }

  void UpdateAccount() {
    emailOrPw = _emailOrPnController.text;
    organization = _organizationController.text;
    password = _passwordPnController.text;
    rePassword = _rePasswordController.text;

    FirebaseFirestore.instance.collection('Accounts').add({
      'emailOrPhone': emailOrPw,
      'organization': organization,
      'password': password
    });
  }

  void textFunc() {}

  Widget renderProducts() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: productList.length,
        itemBuilder: (val, index) {
          return ProductContainer(
            productName: productList[index].data()["itemName"],
            unit: productList[index].data()["unit"],
            price: productList[index].data()["price"],
            owner: productList[index].data()["addedBy"],
            function: () => editProduct(productList[index].reference.id),
          ); ////Text(productList[index].reference.id);//ProductContainer(productName: _list[index],);
        },
      ),
    );
  }

  String imageUrl = "";
  String capturedImage = "";
  XFile? file;

  Future AddImage() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.camera);
    capturedImage = '${file?.path}';

    if (file == null) return;

    Reference refRoot = FirebaseStorage.instance.ref();
    Reference refDirImage = refRoot.child('images');

    Reference refToImageUpload =
        refDirImage.child(DateTime.now().microsecondsSinceEpoch.toString());

    await refToImageUpload.putFile(File(file!.path));
    imageUrl = await refToImageUpload.getDownloadURL();
    setState(() {
      uploadedImage = imageUrl;
    });
    print("---------------- 5 ------------ >" + imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(
                height: 25,
              ),
              Center(
                child: Image.network(
                  uploadedImage,
                  height: 200,
                ),
              ),
              Center(
                child: IconButton(
                    onPressed: () => AddImage(), icon: Icon(Icons.camera)),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Hello! " + accId,
                style: TextStyle(
                    fontSize: 50,
                    fontFamily: "BerkshireSwash",
                    color: Color.fromRGBO(25, 140, 10, 1)),
              ),
              Container(
                child: Row(
                  children: [
                    Text("Created Date : "),
                    Text("2023-10-01"),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextboxWidget(
                controller: _emailOrPnController,
                isPassword: false,
                hint: "Email / Phone No",
                icon: Icon(Icons.email),
              ),
              SizedBox(
                height: 15,
              ),
              TextboxWidget(
                  controller: _organizationController,
                  isPassword: false,
                  hint: "Organization(Optional)",
                  icon: Icon(Icons.person)),
              SizedBox(
                height: 15,
              ),
              TextboxWidget(
                  controller: _passwordPnController,
                  isPassword: true,
                  hint: "Password",
                  icon: Icon(Icons.key)),
              SizedBox(
                height: 15,
              ),
              TextboxWidget(
                  controller: _rePasswordController,
                  isPassword: true,
                  hint: "Re-Enter Password",
                  icon: Icon(Icons.key)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MainButtonWidget(
                    title: "Update Account",
                    onPressed: textFunc,
                    width: 200,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Products",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              productList == [] ? Text("Empty") : renderProducts()
            ],
          ),
        ),
      ),
    );
  }
}
