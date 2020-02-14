import 'package:flutter/material.dart';
import 'package:freeapp_accounts_app/db/accountStatementDb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountStatement extends StatefulWidget {
  final String teamMemberInvolved;
  final String statementType;
  final int monthNumber;

  AccountStatement({
    this.teamMemberInvolved = "0",
    this.statementType = "0",
    this.monthNumber = 0,
  });

  @override
  _AccountStatementState createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  // List statementsList = AccountStatementDb().products();
  // var statementsList = [
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 1,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 1,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //    {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //    {
  // "Id": "474748y484944",
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  //   {
  //     "nameOfEntry": "nameOfEntry",
  //     "amount": 10000.0,
  //     "description": "Web Hosting for FreeApp Web",
  //     "timestamp": 152345677,
  //     "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
  //     "statementType": "Credit",
  //     "numberOfValidation": 2,
  //     "dateTime": "2017-12-13",
  //     "monthNumber": 2
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('account_statements').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final statement = SingleStatement.fromSnapshot(data);

    return Material(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: Icon(Icons.bookmark),
          // enabled: statement.numberOfValidation == 2 ? true : false,
          title: Text(statement.nameOfEntry),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}


class SingleStatement{

  final DocumentReference reference;

  final String id;
  final String nameOfEntry;
  final double amount;
  final String description;
  final int timestamp;
  final List<String> teamMembersInvolved;
  final String statementType;
  final int numberOfValidation;
  final String dateTime;
  final int monthNumber;

  SingleStatement.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        nameOfEntry = map['nameOfEntry'],
        amount = map['amount'],
        description = map['description'],
        timestamp = map['timestamp'],
        teamMembersInvolved = map['teamMembersInvolved'],
        statementType = map['statementType'],
        numberOfValidation = map['numberOfValidation'],
        dateTime = map['dateTime'],
        monthNumber = map['monthNumber'];

        SingleStatement.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}







// class SingleStatement extends StatelessWidget {
  // final String id;
  // final String nameOfEntry;
  // final double amount;
  // final String description;
  // final int timestamp;
  // final List<String> teamMembersInvolved;
  // final String statementType;
  // final int numberOfValidation;
  // final String dateTime;
  // final int monthNumber;

//   SingleStatement(
//       {this.id,
//       this.nameOfEntry,
//       this.amount,
//       this.description,
//       this.timestamp,
//       this.teamMembersInvolved,
//       this.statementType,
//       this.numberOfValidation,
//       this.dateTime,
//       this.monthNumber});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: InkWell(
//         onTap: () {},
//         child: ListTile(
//           leading: Icon(Icons.bookmark),
//           enabled: numberOfValidation == 2 ? true : false,
//           title: Text(nameOfEntry),
//           trailing: Icon(Icons.keyboard_arrow_right),
//         ),
//       ),
//     );
//   }
// }

//  return ListView.builder(
//         itemCount: statementsList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: SingleStatement(
//                 id: statementsList[index]['Id'],
//                 nameOfEntry: statementsList[index]['nameOfEntry'],
//                 amount: statementsList[index]['amount'],
//                 description: statementsList[index]['description'],
//                 timestamp: statementsList[index]['timestamp'],
//                 teamMembersInvolved: statementsList[index]['teamMembersInvolved'],
//                 statementType: statementsList[index]['statementType'],
//                 numberOfValidation: statementsList[index]['numberOfValidation'],
//                 dateTime: statementsList[index]['dateTime'],
//                 monthNumber: statementsList[index]['monthNumber'],
//               ));
//         });
