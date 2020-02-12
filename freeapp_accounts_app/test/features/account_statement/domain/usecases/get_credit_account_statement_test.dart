import 'package:dartz/dartz.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/repositories/account_statement_repository.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/usecases/get_credit_account_statement.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAccountStatementRepository extends Mock
    implements AccountStatementRepository {}

void main() {
  GetCreditAccountStatment usecase;
  MockAccountStatementRepository mockAccountStatementRepository;

  setUp(() {
    mockAccountStatementRepository = MockAccountStatementRepository();
    usecase = GetCreditAccountStatment(mockAccountStatementRepository);
  });

  final tStatementType = 'Credit';
  final tAccountStatement = AccountStatement(nameOfEntry: "Web Hosting", 
                                              amount: 10000.0, 
                                              description: "Web Hosting for FreeApp Web", 
                                              timestamp: "152345677",
                                              teamMembersInvolved: ["Tunde Adewole","Philip Nnamdi"] ,
                                              statementType: "Credit",
                                              numberOfValidation: 2, 
                                              dateTime: "2017-12-13");

  test(
    'should get credit account statement for the credit account statement type from the repository',
    () async {
      // arrange
      when(mockAccountStatementRepository.getCreditAccountStatement(any))
          .thenAnswer((_) async => Right(tAccountStatement));
      // act
      final result = await usecase(Params(statementType: tStatementType));
      // assert
      expect(result, Right(tAccountStatement));
      verify(mockAccountStatementRepository.getCreditAccountStatement(tStatementType));
      verifyNoMoreInteractions(mockAccountStatementRepository);
    },
  );
}