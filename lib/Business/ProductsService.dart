import 'package:agretech_app/Business/Models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Data/Repository/Repository.dart';

class ProductsService{

  Future<List<dynamic>> GetProducts() async{
    var repo = new Repository();
    var result = await repo.ReadData('Products');
    return result;
  }

  bool AddProducts(ProductModel model){
    FirebaseFirestore.instance.collection('Products').add({
      'itemName': model.name,
      'price':model.price,
      'quantity':model.quantity,
      'unit':model.unit,
      'type':model.type,
      'addedBy':model.owner
    });

    return true;
  }
}