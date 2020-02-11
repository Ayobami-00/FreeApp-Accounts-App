import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/account_statement.dart';

abstract class AccountStatementRepository {
  Future<Either<Failure, AccountStatement>> getCreditAccountStatment(String statementType);
  Future<Either<Failure, AccountStatement>> getDebitAccountStatement(String statementType);
  Future<Either<Failure, AccountStatement>> getVerifiableAccountStatement(String teamMemberUserId);
  Future<Either<Failure, AccountStatement>> getMonthlyAccountStatement(String monthNumber);
}
