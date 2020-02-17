import 'package:cloud_firestore/cloud_firestore.dart';


class Verify{
  Firestore _firestore = Firestore.instance;
  
  void update(String ref,Map<String, dynamic> data) {

    _firestore.collection(ref).document(data["uid"]).updateData(data);
  }
}