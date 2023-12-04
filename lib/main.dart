import 'package:agretech_app/Application/Pages/Item_insert_page.dart';
import 'package:agretech_app/Application/Pages/account_page.dart';
import 'package:agretech_app/Application/Pages/login_page.dart';
import 'package:agretech_app/Application/Pages/main_page.dart';
import 'package:agretech_app/Application/Pages/products_page.dart';
import 'package:agretech_app/Application/Pages/signup_page.dart';
import 'package:agretech_app/Data/OfflineDataLayer.dart';
import 'package:agretech_app/Data/Repository/Repository.dart';
import 'package:agretech_app/Application/Widgets/product_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Repository.initDbConnection();
  OfflineDataLayer.initOffilineStorage();

  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromRGBO(10, 10, 10, 0),
      statusBarColor: Color.fromRGBO(10, 10, 10, 0),
      statusBarIconBrightness: Brightness.dark));


  // await Hive.initFlutter();
  // await Hive.openBox('localCache');

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
