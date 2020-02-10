import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';
import 'package:meta/meta.dart';

class AccountStatementModel extends AccountStatement {

  final String nameOfEntry;
  final double amount;
  final String description;
  final String timestamp;
  final List<String> teamMembersInvolved;
  final String statementType;

  AccountStatementModel({ 
  @required this.nameOfEntry, 
  @required this.amount, 
  @required this.description,
  @required this.timestamp, 
  @required this.teamMembersInvolved,
  @required this.statementType,
  }) : super(nameOfEntry:nameOfEntry, amount:amount, description: description, timestamp: timestamp, teamMembersInvolved: teamMembersInvolved, statementType: statementType);

  factory AccountStatementModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementModel(
      nameOfEntry: json['nameOfEntry'], 
      amount: (json['amount'] as num).toDouble(), 
      description: json['description'], 
      timestamp: json['timestamp'], 
      teamMembersInvolved: json['teamMembersInvolved'], 
      statementType: json['statementType'],

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
    };
  }
}
