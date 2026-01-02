

import 'package:hubtel_merchant_checkout_sdk/src/network_manager/network_manager.dart';

class OtpRequestResponse implements Serializable {
  final String? requestId;
  final String? otpPrefix;
  final String? otpApprovalStatus;

  OtpRequestResponse({
    required this.requestId,
    required this.otpPrefix,
    required this.otpApprovalStatus,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'otpPrefix': otpPrefix,
      'otpApprovalStatus': otpApprovalStatus,
    };
  }

  factory OtpRequestResponse.fromJson(Map<String, dynamic>? json) {
    return OtpRequestResponse(
      requestId: json?['requestId'],
      otpPrefix: json?['otpPrefix'],
      otpApprovalStatus: json?['otpApprovalStatus'],
    );
  }
}
