import '../../network_manager/network_manager.dart';
import 'checkout_type.dart';

class NewGetFeesResponse implements Serializable {
  final num? fees;
  final double? amountPayable;
  final String? checkoutType;

  NewGetFeesResponse({
     this.fees,
     this.amountPayable,
     this.checkoutType,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'fees': fees,
      'amountPayable': amountPayable,
      'checkoutType': checkoutType,
    };
  }

  factory NewGetFeesResponse.fromJson(Map<String, dynamic>? json) {
    return NewGetFeesResponse(
      fees: json?['fees'],
      amountPayable: json?['amountPayable'],
      checkoutType: json?['checkoutType'],
    );
  }

  CheckoutType getCheckoutType() {
    switch (checkoutType?.toLowerCase()) {
      case "receivemoneyprompt":
        return CheckoutType.receivemoneyprompt;
      case "preapprovalconfirm":
        return CheckoutType.preapprovalconfirm;
      case "directdebit":
        return CheckoutType.directdebit;
      default:
        return CheckoutType.directdebit;
    }
  }
}
