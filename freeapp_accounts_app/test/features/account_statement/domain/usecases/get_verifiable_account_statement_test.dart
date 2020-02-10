import 'package:dartz/dartz.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/repositories/account_statement_repository.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/usecases/get_verifiable_account_statement.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAccountStatementRepository extends Mock
    implements AccountStatementRepository {}

void main() {
  GetVerifiableAccountStatment usecase;
  MockAccountStatementRepository mockAccountStatementRepository;

  setUp(() {
    mockAccountStatementRepository = MockAccountStatementRepository();
    usecase = GetVerifiableAccountStatment(mockAccountStatementRepository);
  });

  final tteamMmberUserId = 'sjhhwu38389309309337ccn';
  final tAccountStatement = AccountStatement(nameOfEntry: "Web Hosting", 
                                              amount: 10000.0, 
                                              description: "Web Hosting for FreeApp Web", 
                                              timestamp: "152345677",
                                              teamMembersInvolved: ["Tunde Adewole","Philip Nnamdi"] ,
                                              statementType: "Debit");

  test(
    'should get account statement for the statement type from the repository',
    () async {
      // arrange
      when(mockAccountStatementRepository.getVerifiableAccountStatement(any))
          .thenAnswer((_) async => Right(tAccountStatement));
      // act
      final result = await usecase(Params(teamMemberUserId: tteamMmberUserId));
      // assert
      expect(result, Right(tAccountStatement));
      verify(mockAccountStatementRepository.getVerifiableAccountStatement(tteamMmberUserId));
      verifyNoMoreInteractions(mockAccountStatementRepository);
    },
  );
}