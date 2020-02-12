import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';
import 'package:meta/meta.dart';

class AccountStatementModel extends AccountStatement {
final String nameOfEntry;
  final double amount;
  final String description;
  final String timestamp;
  final List<String> teamMembersInvolved;
  final String statementType;
  final int numberOfValidation;
  final String dateTime;

  AccountStatementModel({ 
                  @required this.nameOfEntry, 
                  @required this.amount, 
                  @required this.description, 
                  @required this.timestamp, 
                  @required this.teamMembersInvolved, 
                  @required this.statementType, 
                  @required this.numberOfValidation, 
                  @required this.dateTime
  }) : super(nameOfEntry:nameOfEntry,amount: amount,description: description,timestamp: timestamp,teamMembersInvolved:teamMembersInvolved,statementType: statementType,numberOfValidation:numberOfValidation,dateTime:dateTime);

  factory AccountStatementModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementModel(
      nameOfEntry: json['nameOfEntry'], 
      amount: (json['amount'] as num).toDouble(), 
      description: json['description'], 
      timestamp: json['timestamp'], 
      teamMembersInvolved: json['teamMembersInvolved'].cast<String>(), 
      statementType: json['statementType'],
      numberOfValidation: (json['numberOfValidation'] as num).toInt(),
      dateTime: json['dateTime'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameOfEntry': nameOfEntry,
      'amount': amount,
      'description': description,
      'timestamp': timestamp,
      'teamMembersInvolved':teamMembersInvolved,
      'statementType': statementType,
      'numberOfValidation': numberOfValidation,
      'dateTime': dateTime,
    };
  }
}
