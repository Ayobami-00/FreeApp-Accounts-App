import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import 'package:freeapp_accounts_app/core/error/failures.dart';
import 'package:freeapp_accounts_app/core/network/network_info.dart';
import 'package:freeapp_accounts_app/features/account_statement/data/datasources/account_statement_remote_data_source.dart';

import '../../domain/entities/account_statement.dart';
import '../../domain/repositories/account_statement_repository.dart';

typedef Future<AccountStatement> _AccountStatementChooser();

class AccountStatementRepositoryImpl implements AccountStatementRepository {

  final AccountStatementRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AccountStatementRepositoryImpl({
    @required this.remoteDataSource, 
    @required this.networkInfo});

  @override
  Future<Either<Failure, AccountStatement>> getCreditAccountStatement(String statementType) async {
    return await _getAccountStatement(() {
      return remoteDataSource.getCreditAccountStatement(statementType);
    });
  }

  @override
  Future<Either<Failure, AccountStatement>> getDebitAccountStatement(String statementType) async {
    return await _getAccountStatement(() {
      return remoteDataSource.getDebitAccountStatement(statementType);
    });
  }

  @override
  Future<Either<Failure, AccountStatement>> getMonthlyAccountStatement(String monthNumber) async {
    return await _getAccountStatement(() {
      return remoteDataSource.getMonthlyAccountStatement(monthNumber);
    });
  }

  @override
  Future<Either<Failure, AccountStatement>> getVerifiableAccountStatement(String teamMemberUserName) async {
    return await _getAccountStatement(() {
      return remoteDataSource.getVerifiableAccountStatement(teamMemberUserName);
    });
  }
  Future<Either<Failure, AccountStatement>> _getAccountStatement(
    _AccountStatementChooser getAccountStatementUsecaseType,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAccountStatement = await getAccountStatementUsecaseType();
        return Right(remoteAccountStatement);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final remoteAccountStatement = await getAccountStatementUsecaseType();
        return Right(remoteAccountStatement);
      } on NotConnectedException {
        return Left(NotConnectedFailure());
      }
          
    }
  }
  
  
}