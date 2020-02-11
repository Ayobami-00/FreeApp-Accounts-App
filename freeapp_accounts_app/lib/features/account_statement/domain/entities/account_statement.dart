import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AccountStatement extends Equatable {
  final String nameOfEntry;
  final double amount;
  final String description;
  final String timestamp;
  final List<String> teamMembersInvolved;
  final String statementType;
  final int numberOfValidation;
  final String dateTime;

  AccountStatement({
                  @required this.nameOfEntry, 
                  @required this.amount, 
                  @required this.description, 
                  @required this.timestamp, 
                  @required this.teamMembersInvolved, 
                  @required this.statementType, 
                  @required this.numberOfValidation, 
                  @required this.dateTime});

  

  @override
  List<Object> get props => [nameOfEntry,amount,description,timestamp,teamMembersInvolved,statementType,numberOfValidation,dateTime];
}
