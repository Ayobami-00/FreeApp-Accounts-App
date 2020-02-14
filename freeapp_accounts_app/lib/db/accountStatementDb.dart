// import 'package:cloud_firestore/cloud_firestore.dart';

// class AccountStatementDb {
//   Firestore _firestore = Firestore();
//   Map<String, dynamic> userDetails = {};

//   Future<List> getTestProducts() async{
//     List featuredProducts = [];
//      await _firestore.collection("account_statements").getDocuments().then((snap){
//         snap.documents.map((snapshot) => featuredProducts.addAll(snapshot.data));
//       });
//     return featuredProducts;
//   }
// }
