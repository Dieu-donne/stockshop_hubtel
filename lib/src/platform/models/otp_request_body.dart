

import 'package:hubtel_merchant_checkout_sdk/src/network_manager/network_manager.dart';

class OtpRequestBody implements Serializable{
  final String customerMsisdn;

  OtpRequestBody({required this.customerMsisdn});

  @override
  Map<String, dynamic> toMap() {
    return {
      'customerMsisdn' : customerMsisdn
    };

  }

}