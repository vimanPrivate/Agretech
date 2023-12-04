import 'package:agretech_app/Application/Pages/signup_page.dart';
import 'package:agretech_app/Application/Widgets/circle_widget.dart';
import 'package:agretech_app/Application/Widgets/home_main_button.dart';
import 'package:agretech_app/Application/Widgets/main_button_widget.dart';
import 'package:agretech_app/Application/Widgets/notification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {}

  void Test() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Stack(
        children: [
          Container(
              height: 90,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          "Entered username is wrong!",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Widget test25() {
    return NotificationWidget();
  }

  String headingFontFamily = 'BerkshireSwash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Take care of your ",
                style: TextStyle(fontSize: 38, fontFamily: headingFontFamily),
              ),
              Text(
                "Plants and Tools here ",
                style: TextStyle(fontSize: 38, fontFamily: headingFontFamily),
              ),
              SizedBox(
                height: 20,
              ),
              HomeMainButton(
                title: "Agreculture Products",
                subTitle: "Rice,Sugar,Spinch etc",
                assetImage:
                    "Assets/Images/FoodTank_agriculturesubsidiesworldbankreport.jpg",
              ),
              HomeMainButton(
                title: "Tools",
                subTitle: "Rice,Sugar,Spinch etc",
                assetImage: "Assets/Images/20201225175913.jpg",
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Free acount",
                      style: TextStyle(
                          fontFamily: 'AlbertSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          margin: EdgeInsets.fromLTRB(0,10, 0, 0),
                          child: Text(
                            "Signup and sell your products. 100% free. enjoy the benifits ",
                            style: TextStyle(
                                fontFamily: 'AlbertSans',
                                fontSize: 18,
                            ),
                          ),
                        ),
                        MainButtonWidget(title: 'Signup',onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder) => SignupPage()));
                        },width: 120,)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleBox(title: 'Green', subTitle: 'Sub Green', assetImage: "Assets/Images/brocoli.png"),
                        CircleBox(title: 'Green', subTitle: 'Sub Green', assetImage: "Assets/Images/tractor.png"),
                      ],
                    ),
                    Row(
                      children: [
                        CircleBox(title: 'Green', subTitle: 'Sub Green', assetImage: "Assets/Images/pinaple.png"),
                        CircleBox(title: 'Green', subTitle: 'Sub Green', assetImage: "Assets/Images/knife.png"),
                      ],
                    ),
                    //NotificationWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
