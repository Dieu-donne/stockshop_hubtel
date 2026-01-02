import 'dart:convert';

import '../../network_manager/serializable.dart';

class BankCardData implements Serializable {
  String? cardNumber;
  String? cardExpiryDate;
  String? cvv;

  BankCardData({this.cardNumber, this.cardExpiryDate, this.cvv});

  factory BankCardData.fromJson(Map<String, dynamic>? json) {
    return BankCardData(
      cardNumber: json?["cardNumber"],
      cardExpiryDate: json?["cardExpiryDate"],
      cvv: json?["cvv"],
    );
  }

  static BankCardData fromString(String? string) {
    return BankCardData.fromJson(jsonDecode(string ?? ""));
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      "cardNumber": cardNumber,
      "cardExpiryDate": cardExpiryDate,
      "cvv": cvv,
    };
  }
}