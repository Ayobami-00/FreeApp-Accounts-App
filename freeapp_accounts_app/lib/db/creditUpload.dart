import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CreditUpload {
  Firestore _firestore = Firestore.instance;
  String ref = 'credits';

  void uploadCredit(Map<String, dynamic> data) {
    var id = Uuid();
    String statementId = id.v1();
    data["uid"] = statementId;
    _firestore.collection(ref).document(data["uid"]).setData(data);
  }
}