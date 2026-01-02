import 'package:hubtel_merchant_checkout_sdk/src/network_manager/network_manager.dart';

class VerifyOtpBody implements Serializable {
  final String requestId;
  final String msisdn;
  final String otpCode;

  VerifyOtpBody({
    required this.requestId,
    required this.msisdn,
    required this.otpCode,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'msisdn': msisdn,
      'otpCode': otpCode
    };
  }
}
