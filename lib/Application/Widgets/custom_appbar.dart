import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({required this.title,required this.backgroundImage});
  final String title ;
  final String backgroundImage ;

  @override
  Widget build(BuildContext context) {
    String defaultBackgroundImage = "Assets/Images/FoodTank_agriculturesubsidiesworldbankreport.jpg";
    return AppBar(
      title: Column(
        children: [
          SizedBox(height: 33,),
          Text(
            title,
            style: TextStyle(
              fontSize: 22
            ),
          ),
        ],
      ),
      centerTitle: true,

      flexibleSpace: Image(
        image: AssetImage(backgroundImage == ""? defaultBackgroundImage:backgroundImage),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  //Size get preferredSize => Size.fromHeight(100);
  Size get preferredSize => Size.fromHeight(160);
}
