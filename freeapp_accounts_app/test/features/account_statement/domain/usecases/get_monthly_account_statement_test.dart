import 'package:dartz/dartz.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/repositories/account_statement_repository.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/usecases/get_monthly_account_statement.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAccountStatementRepository extends Mock
    implements AccountStatementRepository {}

void main() {
  GetMonthlyAccountStatment usecase;
  MockAccountStatementRepository mockAccountStatementRepository;

  setUp(() {
    mockAccountStatementRepository = MockAccountStatementRepository();
    usecase = GetMonthlyAccountStatment(mockAccountStatementRepository);
  });

  final tMonthNumber = '1';
  final tAccountStatement = AccountStatement(nameOfEntry: "Web Hosting", 
                                              amount: 10000.0, 
                                              description: "Web Hosting for FreeApp Web", 
                                              timestamp: "152345677",
                                              teamMembersInvolved: ["Tunde Adewole","Philip Nnamdi"] ,
                                              statementType: "Debit",
                                              numberOfValidation: 2, 
                                              dateTime: "2017-12-13");

  test(
    'should get account statement for the statement type from the repository',
    () async {
      // arrange
      when(mockAccountStatementRepository.getMonthlyAccountStatement(any))
          .thenAnswer((_) async => Right(tAccountStatement));
      // act
      final result = await usecase(Params(monthNumber: tMonthNumber));
      // assert
      expect(result, Right(tAccountStatement));
      verify(mockAccountStatementRepository.getMonthlyAccountStatement(tMonthNumber));
      verifyNoMoreInteractions(mockAccountStatementRepository);
    },
  );
}