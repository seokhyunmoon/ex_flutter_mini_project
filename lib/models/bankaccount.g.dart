// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankaccount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      id: json['id'] as int?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      bank_company: json['bank_company'] as String?,
      val_date: json['val_date'] as String?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'bank_company': instance.bank_company,
      'val_date': instance.val_date,
      'created_at': instance.created_at,
    };
