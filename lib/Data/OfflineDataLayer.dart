import 'dart:convert';

import 'package:agretech_app/Business/Models/ProductModel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class OfflineDataLayer{
  static Future<void> initOffilineStorage() async{
    await Hive.initFlutter();
    await Hive.openBox('localCache');
  }
  
  void storeProductsValues(List<dynamic> productList){
    final _localCache = Hive.box('localCache');

    int count = 1;
    productList.forEach((element) {
      var model = new ProductModel();

      model.name = element.data()["itemName"];
      model.quantity = element.data()["quantity"];
      model.price = element.data()["price"];
      model.owner = element.data()["addedBy"];

      var json = jsonEncode(model);
      _localCache.put(count, json);

      count++;
    });
  }
  
  Box<dynamic> getStoredValues(){
    final _localCache = Hive.box('localCache');
    return _localCache;
  }
}