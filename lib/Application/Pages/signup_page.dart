import 'package:agretech_app/Business/AccountService.dart';
import 'package:agretech_app/Business/Models/AccountModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/textbox_widget.dart';
import 'main_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailOrPnController = TextEditingController();
  final _organizationController = TextEditingController();
  final _passwordPnController = TextEditingController();
  final _rePasswordController = TextEditingController();

  var accountModel = new AccountModel();

  void CreateAccount(){
    accountModel.email = _emailOrPnController.text;
    accountModel.organization = _organizationController.text;
    accountModel.password = _passwordPnController.text;
    accountModel.reEnterPassword = _rePasswordController.text;

    var accountService = new AccountsService();
    bool result = accountService.createAccount(accountModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(27),
          color: Color.fromRGBO(221, 250, 190,1),
          height: 925,
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
                  TextboxWidget(controller: _organizationController,isPassword: false,hint: "Organization(Optional)",icon: Icon(Icons.person)),
                  SizedBox(height: 15,),
                  TextboxWidget(controller: _passwordPnController,isPassword: true,hint: "Password",icon: Icon(Icons.key)),
                  SizedBox(height: 15,),
                  TextboxWidget(controller: _rePasswordController,isPassword: true,hint: "Re-Enter Password",icon: Icon(Icons.key)),
                  SizedBox(height: 35,),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => CreateAccount(),
                          child: Text(
                            "Create Account",
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
                        "Already have an account ?",
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, "/loginpage");
                          },
                          child: Text(
                            "Login",
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
