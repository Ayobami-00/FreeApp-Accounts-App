import 'dart:convert';
import 'package:meta/meta.dart';


import '../models/account_statement_model.dart';

abstract class AccountStatementRemoteDataSource {

  Future<AccountStatementModel> getCreditAccountStatment(String statementType);
  Future<AccountStatementModel> getDebitAccountStatement(String statementType);
   Future<AccountStatementModel> getVerifiableAccountStatement(String teamMemberUserId);
}

