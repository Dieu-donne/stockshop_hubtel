
import '../../network_manager/network_manager.dart';

class PreApprovalResponse implements Serializable {
  String? preapprovalStatus;
  String? verificationType;
  String? clientReference;
  String? hubtelPreapprovalId;
  String? otpPrefix;
  String? customerMsisdn;
  bool? skipOtp;

  PreApprovalResponse({
    this.preapprovalStatus,
    this.verificationType,
    this.clientReference,
    this.hubtelPreapprovalId,
    this.otpPrefix,
    this.customerMsisdn,
    this.skipOtp,
  });

  factory PreApprovalResponse.fromJson(Map<String, dynamic>? json) {
    return PreApprovalResponse(
      preapprovalStatus: json?['preapprovalStatus'],
      verificationType: json?['verificationType'],
      clientReference: json?['clientReference'],
      hubtelPreapprovalId: json?['hubtelPreapprovalId'],
      otpPrefix: json?['otpPrefix'],
      customerMsisdn: json?['customerMsisdn'],
      skipOtp: json?['skipOtp'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
