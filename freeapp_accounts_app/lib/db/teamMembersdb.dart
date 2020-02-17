import 'package:cloud_firestore/cloud_firestore.dart';

class TeamMembersListService{
  Firestore _firestore = Firestore.instance;
  String ref = 'users';

  Future<List<DocumentSnapshot>> getCategories() => _firestore.collection(ref).getDocuments().then((snaps){
      print(snaps.documents.length);
      return snaps.documents;
    });
}