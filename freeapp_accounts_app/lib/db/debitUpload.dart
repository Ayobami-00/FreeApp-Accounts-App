import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DebitUpload {
  Firestore _firestore = Firestore.instance;
  String ref = 'debits';

  void uploadDebit(Map<String, dynamic> data) {
    var id = Uuid();
    String statementId = id.v1();
    data["uid"] = statementId;
    _firestore.collection(ref).document(data["uid"]).setData(data);
  }
}