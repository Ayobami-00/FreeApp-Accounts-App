import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Credits extends StatefulWidget {
  @override
  _CreditsState createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 10.0),
              Text("Credits",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  FlatButton.icon(
                    onPressed: (){}, 
                    icon: Icon(Icons.arrow_drop_down), 
                    label: Text("Chose View Category"))
            ],
          ),
          SizedBox(height: 10.0),
              Flexible(child: _buildBody(context)),
        ],
      ),
     
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('debits').orderBy('timestamp').
      where('statementType',isEqualTo: 'Credit').
      snapshots(),
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
          enabled: statement.numberOfValidation == 2 ? true : false,
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
        amount = (map['amount'] as num).toDouble(),
        description = map['description'],
        timestamp = (map['timestamp'] as num).toInt(),
        teamMembersInvolved = map['teamMembersInvolved'].cast<String>(),
        statementType = map['statementType'],
        numberOfValidation = (map['numberOfValidation']as num).toInt(),
        dateTime = map['dateTime'],
        monthNumber = (map['monthNumber'] as num).toInt();

        SingleStatement.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}
