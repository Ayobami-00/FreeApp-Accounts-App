import 'package:dartz/dartz.dart';
import 'package:freeapp_accounts_app/core/error/exceptions.dart';
import 'package:freeapp_accounts_app/core/error/failures.dart';
import 'package:freeapp_accounts_app/core/network/network_info.dart';
import 'package:freeapp_accounts_app/features/account_statement/data/datasources/account_statement_remote_data_source.dart';
import 'package:freeapp_accounts_app/features/account_statement/data/models/account_statement_model.dart';
import 'package:freeapp_accounts_app/features/account_statement/data/repositories/account_statement_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements AccountStatementRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AccountStatementRepositoryImpl repository;
  AccountStatementRemoteDataSource mockRemoteDataSource;
  NetworkInfo mockNetworkInfo;
  
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AccountStatementRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

   void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getCreditAccountStatement', () {
  final tStatementType = 'Credit';
  final tAccountStatementModel = AccountStatementModel(nameOfEntry: "Web Hosting", 
                                              amount: 10000.0, 
                                              description: "Web Hosting for FreeApp Web", 
                                              timestamp: "152345677",
                                              teamMembersInvolved: ["Tunde Adewole","Philip Nnamdi"] ,
                                              statementType: "Credit",
                                              numberOfValidation: 2, 
                                              dateTime: "2017-12-13");
                                              
  final AccountStatement tAccountStatement = tAccountStatementModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getCreditAccountStatement(tStatementType);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCreditAccountStatement(any))
              .thenAnswer((_) async => tAccountStatementModel);
          // act
          final result = await repository.getCreditAccountStatement(tStatementType);
          // assert
          verify(mockRemoteDataSource.getCreditAccountStatement(tStatementType));
          expect(result, equals(Right(tAccountStatement)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCreditAccountStatement(any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getCreditAccountStatement(tStatementType);
          // assert
          verify(mockRemoteDataSource.getCreditAccountStatement(tStatementType));
          expect(result, equals(Left(ServerFailure())));
        },
      );


       test(
        'should return not connected failure when device is offline',
        () async {
          // arrange
          when(mockRemoteDataSource.getCreditAccountStatement(any))
              .thenThrow(NotConnectedException());
          // act
          final result = await repository.getCreditAccountStatement(tStatementType);
          // assert
          verify(mockRemoteDataSource.getCreditAccountStatement(tStatementType));
          expect(result, equals(Left(NotConnectedFailure())));
        },
      );

    });


   

});


 group('getDebitAccountStatement', () {
  final tStatementType = 'Debit';
  final tAccountStatementModel = AccountStatementModel(nameOfEntry: "Web Hosting", 
                                              amount: 10000.0, 
                                              description: "Web Hosting for FreeApp Web", 
                                              timestamp: "152345677",
                                              teamMembersInvolved: ["Tunde Adewole","Philip Nnamdi"] ,
                                              statementType: "Credit",
                                              numberOfValidation: 2, 
                                              dateTime: "2017-12-13");
                                              
  final AccountStatement tAccountStatement = tAccountStatementModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getDebitAccountStatement(tStatementType);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getDebitAccountStatement(any))
              .thenAnswer((_) async => tAccountStatementModel);
          // act
          final result = await repository.getDebitAccountStatement(tStatementType);
          // assert
          verify(mockRemoteDataSource.getDebitAccountStatement(tStatementType));
          expect(result, equals(Right(tAccountStatement)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getDebitAccountStatement(any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getDebitAccountStatement(tStatementType);
          // assert
          verify(mockRemoteDataSource.getDebitAccountStatement(tStatementType));
          expect(result, equals(Left(ServerFailure())));
        },
      );


       test(
        'should return not connected failure when device is offline',
        () async {
          // arrange
          when(mockRemoteDataSource.getDebitAccountStatement(any))
              .thenThrow(NotConnectedException());
          // act
          final result = await repository.getDebitAccountStatement(tStatementType);
          // assert
          verify(mockRemoteDataSource.getDebitAccountStatement(tStatementType));
          expect(result, equals(Left(NotConnectedFailure())));
        },
      );
      

    });
   

});



 group('getMonthlyAccountStatement', () {
  final tMonthNumber = '1';
  final tAccountStatementModel = AccountStatementModel(nameOfEntry: "Web Hosting", 
                                              amount: 10000.0, 
                                              description: "Web Hosting for FreeApp Web", 
                                              timestamp: "152345677",
                                              teamMembersInvolved: ["Tunde Adewole","Philip Nnamdi"] ,
                                              statementType: "Credit",
                                              numberOfValidation: 2, 
                                              dateTime: "2017-12-13");
                                              
  final AccountStatement tAccountStatement = tAccountStatementModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getMonthlyAccountStatement(tMonthNumber);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getMonthlyAccountStatement(any))
              .thenAnswer((_) async => tAccountStatementModel);
          // act
          final result = await repository.getMonthlyAccountStatement(tMonthNumber);
          // assert
          verify(mockRemoteDataSource.getMonthlyAccountStatement(tMonthNumber));
          expect(result, equals(Right(tAccountStatement)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getMonthlyAccountStatement(any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMonthlyAccountStatement(tMonthNumber);
          // assert
          verify(mockRemoteDataSource.getMonthlyAccountStatement(tMonthNumber));
          expect(result, equals(Left(ServerFailure())));
        },
      );


       test(
        'should return not connected failure when device is offline',
        () async {
          // arrange
          when(mockRemoteDataSource.getMonthlyAccountStatement(any))
              .thenThrow(NotConnectedException());
          // act
          final result = await repository.getMonthlyAccountStatement(tMonthNumber);
          // assert
          verify(mockRemoteDataSource.getMonthlyAccountStatement(tMonthNumber));
          expect(result, equals(Left(NotConnectedFailure())));
        },
      );
      

    });
   

});


group('getVerifiableAccountStatement', () {
  final tteamMemberUserName = '1';
  final tAccountStatementModel = AccountStatementModel(nameOfEntry: "Web Hosting", 
                                              amount: 10000.0, 
                                              description: "Web Hosting for FreeApp Web", 
                                              timestamp: "152345677",
                                              teamMembersInvolved: ["Tunde Adewole","Philip Nnamdi"] ,
                                              statementType: "Credit",
                                              numberOfValidation: 2, 
                                              dateTime: "2017-12-13");
                                              
  final AccountStatement tAccountStatement = tAccountStatementModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getVerifiableAccountStatement(tteamMemberUserName);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getVerifiableAccountStatement(any))
              .thenAnswer((_) async => tAccountStatementModel);
          // act
          final result = await repository.getVerifiableAccountStatement(tteamMemberUserName);
          // assert
          verify(mockRemoteDataSource.getVerifiableAccountStatement(tteamMemberUserName));
          expect(result, equals(Right(tAccountStatement)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getVerifiableAccountStatement(any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getVerifiableAccountStatement(tteamMemberUserName);
          // assert
          verify(mockRemoteDataSource.getVerifiableAccountStatement(tteamMemberUserName));
          expect(result, equals(Left(ServerFailure())));
        },
      );


       test(
        'should return not connected failure when device is offline',
        () async {
          // arrange
          when(mockRemoteDataSource.getMonthlyAccountStatement(any))
              .thenThrow(NotConnectedException());
          // act
          final result = await repository.getVerifiableAccountStatement(tteamMemberUserName);
          // assert
          verify(mockRemoteDataSource.getVerifiableAccountStatement(tteamMemberUserName));
          expect(result, equals(Left(NotConnectedFailure())));
        },
      );
      

    });
   

});


}