import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/bankaccount.dart';

class AsyncBankAccountsNotifier extends AsyncNotifier<List<BankAccount>> {
  Future<List<BankAccount>> _fetchBankAccounts() async {
    final response = await http.get(Uri.http('localhost:3000', '/bankaccount'));
    final bankaccountJson = jsonDecode(response.body) as List;
    final bankaccount = bankaccountJson
        .map((bankaccountJson) => BankAccount.fromJson(bankaccountJson as Map<String, dynamic>))
        .toList();
    return bankaccount;
  }

  @override
  Future<List<BankAccount>> build() async {
    // Load initial bankaccount list from the remote repository
    return _fetchBankAccounts();
  }

  Future<void> addBankAccount(BankAccount bankaccount) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new bankaccount and reload the bankaccount list from the remote repository
    state = await AsyncValue.guard(() async {
      await http.post(Uri.http('localhost:3000', '/bankaccount'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(bankaccount.toJson()));
      return _fetchBankAccounts();
    });
  }

  // Let's allow removing bankaccs
  Future<void> removeBankAccount(String bankaccountId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.delete(Uri.http('localhost:3000', '/bankaccount/$bankaccountId'));
      return _fetchBankAccounts();
    });
  }

  // Let's mark a bankaccount as completed
  Future<void> toggle(String bankaccId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.patch(
        Uri.http('localhost:3000', '/bankaccount/$bankaccId'),
        headers: {'Content-Type': 'application/json'},
        body: <String, dynamic>{'isActive': true},
      );
      return _fetchBankAccounts();
    });
  }
}

final asyncBankAccountsProvider =
    AsyncNotifierProvider<AsyncBankAccountsNotifier, List<BankAccount>>(() {
  return AsyncBankAccountsNotifier();
});
