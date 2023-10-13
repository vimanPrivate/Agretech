import 'package:agretech_app/Pages/Item_insert_page.dart';
import 'package:agretech_app/Pages/account_page.dart';
import 'package:agretech_app/Pages/login_page.dart';
import 'package:agretech_app/Pages/main_page.dart';
import 'package:agretech_app/Pages/products_page.dart';
import 'package:agretech_app/Pages/signup_page.dart';
import 'package:agretech_app/Widgets/product_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'xxxx',
      options: FirebaseOptions(
          apiKey: "AIzaSyC4qD5FUGmfgTbxHd5OA4HGvuWc5lhwEjw",
          appId: "1:346915777564:web:c390e2ba624aba91d9c3d9",
          messagingSenderId: "346915777564",
          projectId: "agretech-6d964"));

  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromRGBO(10, 10, 10, 0),
      statusBarColor: Color.fromRGBO(10, 10, 10, 0),
      statusBarIconBrightness: Brightness.dark));

  await Hive.initFlutter();
  var box = await Hive.openBox('localCache');

  runApp(MaterialApp(
    home: MainPage(),
    routes: {
      "/loginpage": (context) => const LoginPage(),
      "/signuppage": (context) => SignupPage(),
    },
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
