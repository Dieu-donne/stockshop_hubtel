
import '../platform/models/models.dart';
import 'checkout_endpoints.dart';

class EndPoints {
  CheckoutEndPoint get checkoutEndPoint => CheckoutEndPoint(
        merchantId: CheckoutRequirements.merchantId,
        apiKey: CheckoutRequirements.apiKey,
        customerMsisdn: CheckoutRequirements.customerMsisdn,
      );
}
