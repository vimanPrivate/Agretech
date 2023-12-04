import 'package:agretech_app/Application/Pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'globals.dart' as globals;
import '../../Utils/globals.dart' as globals;

import '../Widgets/textbox_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailOrPnController = TextEditingController();
  final _passwordController = TextEditingController();

  String emailOrPhoneNo = "";
  String password = "";

  List<dynamic> usersList = [];

  @override
  void initState() {
    super.initState();

    print(globals.testVatr);
    fetchValues();
  }

  void fetchValues () async{
    await FirebaseFirestore.instance.collection('Accounts').get().then(
            (snapshot) => snapshot.docs.forEach(
                (document) {
              //print(document.data()["emailOrPhone"]);
              setState(() {
                usersList.add(document);
              });
             print(usersList);
            })
    );
  }

  void LoginUser(){
    setState(() {
      emailOrPhoneNo = _emailOrPnController.text;
      password = _passwordController.text;
    });

    for(final e in usersList){
        if(e.data()["emailOrPhone"] == emailOrPhoneNo){
          if(e.data()["password"] == password){
            globals.isLoggedIn = true;
            globals.userId = emailOrPhoneNo;

            Navigator.push(context, MaterialPageRoute(builder: (builder) => LoginPage()));
            print("fine ------------- You can enter -------------------");
          }
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(27),
          color: Color.fromRGBO(221, 250, 190,1),
          height: 930,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'Assets/Logos/pngwing.com.png',
                        width: 100,
                        height: 100,
                      )
                  )
                ],
              ),
              SizedBox(height: 60,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextboxWidget(controller: _emailOrPnController,isPassword: false,hint: "Email / Phone No",icon: Icon(Icons.email),),
                  SizedBox(height: 15,),
                  TextboxWidget(controller: _passwordController,isPassword: true,hint: "Password", icon: Icon(Icons.key),),
                  SizedBox(height: 25,),
                  Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  SizedBox(height: 25,),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => LoginUser(),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(28, 51, 3, 1)
                              ),
                              shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(30)
                                  )
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, "/signuppage");
                          },
                          child: Text(
                            "Click Here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (builder) => MainPage()));
                          },
                          child: Text(
                            "Go back to Home page",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          )
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
