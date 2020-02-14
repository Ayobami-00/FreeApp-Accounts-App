import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDb{
  Firestore _firestore = Firestore();
  Map<String, dynamic> userDetails = {};
  Future<bool> validateEmail(String email, String password) async {
    try{
      await _firestore.collection('users')
    .document(password)
    .get()
    .then((val){
      userDetails.addAll(val.data);
    });
    }catch(e){
      return false;
    }
    if (email == userDetails["email"] && password == userDetails["password"]){
          return true;
        }else{
          return false;
        }

     
  }
  }
      



