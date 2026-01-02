import '../../network_manager/network_manager.dart';

class PreapprovalConfirm implements Serializable {
  String channel;
  String amount;
  String clientReference;
  String customerMsisdn;
  String description;

  PreapprovalConfirm.create(
      this.channel, this.amount, this.clientReference, this.customerMsisdn, this.description);

  @override
  Map<String, dynamic> toMap() {
    return {
      "channel": channel,
      "amount": amount,
      "clientReference": clientReference,
      "customerMsisdn": customerMsisdn,
      "description": description
    };
  }
}
