import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:freeapp_accounts_app/features/account_statement/data/models/account_statement_model.dart';
import 'package:freeapp_accounts_app/features/account_statement/domain/entities/account_statement.dart';

void main() {
  final tAccountStatementModel = AccountStatementModel(
      nameOfEntry: "Web Hosting",
      amount: 10000.0,
      description: "Web Hosting for FreeApp Web",
      timestamp: "152345677",
      teamMembersInvolved: ["Tunde Adewole", "Philip Nnamdi"],
      statementType: "Credit");

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // assert
      expect(tAccountStatementModel, isA<AccountStatement>());
    },
  );

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tAccountStatementModel.toJson();
        // assert
        final expectedMap = {
            "nameOfEntry": "Web Hosting",
            "amount": "Hosting for FreeApp Web",
            "description": "Hosting for FreeApp Web",
            "timestamp": "15666789999",
            "teamMembersInvolved": ["Tunde Adewole", "Philip Nnamdi"],
            "statementType": "Credit"
        };
        expect(result, expectedMap);
      },
    );
  });
}
