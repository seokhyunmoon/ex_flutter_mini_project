import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_mini_project/provider/bankaccountProvider.dart';
import 'package:ex_mini_project/models/bankaccount.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
// final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final asyncBankAccounts = ref.watch(asyncBankAccountsProvider);
      final bankaccountNotifier = ref.read(asyncBankAccountsProvider.notifier);

      TextEditingController nameController = TextEditingController();

      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(),
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad
        },
      ),
      child: RefreshIndicator(
        onRefresh: () => ref.refresh(asyncBankAccountsProvider.future), // RefreshIndicator를 사용하여 화면을 아래로 당겨 새로고침 가능
        child: Center(
            child: switch (asyncBankAccounts) {
          AsyncData(:final value) => ListView(
              children: [
                for (final bankaccount in value)
                  ListTile(
                    title: Text(bankaccount.last_name!),
                  ),
                  // 추가: 사용자 추가 폼
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final newBankAccount = BankAccount(last_name: nameController.text);
                          bankaccountNotifier.addBankAccount(newBankAccount);
                          nameController.clear();
                        },
                        child: Text('Add BankAccount'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          AsyncError(:final error) => Text('Error: $error'),
          _ => const Center(child: CircularProgressIndicator()),
        }),
      ))));
    });
  }
}