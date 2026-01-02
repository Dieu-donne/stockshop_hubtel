
import 'package:hubtel_merchant_checkout_sdk/src/network_manager/network_manager.dart';

class OtpResponse  implements Serializable{
  final String? customerMsisdn;
  final String? verificationType;
  final String? preapprovalStatus;
  final String? clientReferenceID;
  final bool? skipOtp;

  OtpResponse({
    this.customerMsisdn,
    this.verificationType,
    this.preapprovalStatus,
    this.clientReferenceID,
    this.skipOtp,
  });

  factory OtpResponse.fromJson(Map<String, dynamic>? json) {
    return OtpResponse(
      customerMsisdn: json?['customerMsisdn'],
      verificationType: json?['verificationType'],
      preapprovalStatus: json?['preapprovalStatus'],
      clientReferenceID: json?['clientReferenceID'],
      skipOtp: json?['skipOtp'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return  {
      'customerMsisdn': customerMsisdn
    };
  }
}