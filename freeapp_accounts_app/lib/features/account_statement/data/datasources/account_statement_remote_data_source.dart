import 'dart:convert';
import 'package:meta/meta.dart';


import '../models/account_statement_model.dart';

abstract class AccountStatementRemoteDataSource {

  Future<AccountStatementModel> getCreditAccountStatement(String statementType);
  Future<AccountStatementModel> getDebitAccountStatement(String statementType);
  Future<AccountStatementModel> getVerifiableAccountStatement(String teamMemberUserName);
  Future<AccountStatementModel> getMonthlyAccountStatement(String monthNumber);
}

