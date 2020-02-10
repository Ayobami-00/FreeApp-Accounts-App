import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freeapp_accounts_app/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:freeapp_accounts_app/core/error/failures.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';

import '../repositories/account_statement_repository.dart';

class GetDebitAccountStatment implements UseCase<AccountStatement, Params> {
  final AccountStatementRepository repository;

  GetDebitAccountStatment(this.repository);
  @override
  Future<Either<Failure, AccountStatement>> call(Params params) async {
    return await repository.getDebitAccountStatement(params.statementType);
  }
}

class Params extends Equatable {
  final String statementType;

  Params({@required this.statementType});

  @override
  List<Object> get props => [statementType];
}
