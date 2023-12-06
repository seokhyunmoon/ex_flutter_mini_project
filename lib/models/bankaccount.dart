import 'package:json_annotation/json_annotation.dart';
part 'bankaccount.g.dart';

@JsonSerializable()
class BankAccount {
  int? id;
  String? first_name;
  String? last_name;
  String? bank_company;
  String? val_date;
  String? created_at;

  BankAccount({
    this.id,
    this.first_name,
    this.last_name,
    this.bank_company,
    this.val_date,
    this.created_at
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => _$BankAccountFromJson(json);
  Map<String,dynamic> toJson() => _$BankAccountToJson(this);
}