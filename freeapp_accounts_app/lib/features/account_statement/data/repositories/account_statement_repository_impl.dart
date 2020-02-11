import 'package:dartz/dartz.dart';
import 'package:freeapp_accounts_app/core/error/failures.dart';

import '../../domain/entities/account_statement.dart';
import '../../domain/repositories/account_statement_repository.dart';

class AccountStatementRepositoryImpl implements AccountStatementRepository {
  @override
  Future<Either<Failure, AccountStatement>> getCreditAccountStatment(String statementType) {
    // TODO: implement getCreditAccountStatment
    return null;
  }

  @override
  Future<Either<Failure, AccountStatement>> getDebitAccountStatement(String statementType) {
    // TODO: implement getDebitAccountStatement
    return null;
  }

  @override
  Future<Either<Failure, AccountStatement>> getMonthlyAccountStatement(String monthNumber) {
    // TODO: implement getMonthlyAccountStatement
    return null;
  }

  @override
  Future<Either<Failure, AccountStatement>> getVerifiableAccountStatement(String teamMemberUserId) {
    // TODO: implement getVerifiableAccountStatement
    return null;
  }
  
  
}