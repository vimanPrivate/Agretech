import 'package:agretech_app/Application/Pages/account_page.dart';
import 'package:agretech_app/Application/Pages/home_page.dart';
import 'package:agretech_app/Application/Pages/products_page.dart';
import 'package:agretech_app/Application/Pages/stats_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    StatsPage(),
    ProductsPage(),
    AccountPage()
  ];

  int curIndex = 0;
  void onTap(int index){
    setState(() {
      curIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[curIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: curIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(label:"Home",icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label:"Bar", icon: Icon(Icons.bar_chart_sharp)),
          BottomNavigationBarItem(label: "Search",icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Person",icon: Icon(Icons.person))
        ],
      ),
    );
  }
}

