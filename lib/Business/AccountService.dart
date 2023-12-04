import 'package:agretech_app/Business/Models/AccountModel.dart';
import 'package:agretech_app/Data/Repository/Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountsService{
  AccountsService(){
  }
  bool createAccount(AccountModel model){
    FirebaseFirestore.instance.collection('Accounts').add({
      'emailOrPhone':model.email,
      'organization':model.organization,
      'password':model.password
    }).then((value) => print('done ---------------------------------------------------------'));

    return false;
  }

  Future<List<dynamic>> GetAccounts() async{
    var repo = new Repository();
    var result = await repo.ReadData('Accounts');
    return result;
  }
}