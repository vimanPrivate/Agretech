import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Repository{
  static Future<void> initDbConnection() async {
    await Firebase.initializeApp(
        name: 'xxxx',
        options: FirebaseOptions(
            apiKey: "AIzaSyC4qD5FUGmfgTbxHd5OA4HGvuWc5lhwEjw", //AIzaSyC4qD5FUGmfgTbxHd5OA4HGvuWc5lhwEjw
            appId: "1:346915777564:web:c390e2ba624aba91d9c3d9",
            messagingSenderId: "346915777564",
            projectId: "agretech-6d964"));
  }

  Future<List<dynamic>> ReadData(String collectionName) async {
    List<dynamic> result = [];
    await FirebaseFirestore.instance.collection(collectionName).get().then(
            (snapshot) => snapshot.docs.forEach(
                (document) {
                result.add(document);
            })
    ).onError((error, stackTrace) {
      print('-------- Error ------------------- Error');
    });

    return result;
  }

  bool AddData(dynamic model, String collection){

    FirebaseFirestore.instance.collection(collection).add({

    }).then((value) => print('done ---------------------------------------------------------'));

    return false;
  }
}