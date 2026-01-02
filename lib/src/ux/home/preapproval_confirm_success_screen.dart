import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/src/core_ui/core_ui.dart';
import '/src/platform/models/models.dart';
import '/src/resources/resources.dart';
import '/src/utils/utils.dart';

class PreApprovalConfirmSuccessScreen extends StatelessWidget {
  String walletName;

  double amount;



  PreApprovalConfirmSuccessScreen(
      {Key? key,
      required this.walletName,
      required this.amount,
 })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "Checkout",
      bottomNavigation: Container(
        color: Colors.white,
        padding: EdgeInsets.all(Dimens.paddingDefault),
        child: CustomButton(
          title: 'AGREE AND CONTINUE',
          isEnabled: true,
          buttonAction: () {
            final checkoutCompletion = CheckoutCompletionStatus(status: UnifiedCheckoutPaymentStatus.paymentSuccess, transactionId: "");
           Navigator.pop(context);
           Navigator.pop(context, checkoutCompletion);
          },
          style: HubtelButtonStyle.solid,
          isEnabledBgColor: ThemeConfig.themeColor,
        ),
      ),
      body: Container(
        color: const Color(0XFFDBF7E0),
        padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(CheckoutDrawables.success),
            const SizedBox(height: 8),
            Text(
              "Your order has been placed",
              textAlign: TextAlign.center,
              style: AppTextStyle.body2(),
            ),
            const SizedBox(height: 8),
            Text(
              "Your $walletName will be debited with ${amount.formatMoney()} after your order is confirmed.",
              textAlign: TextAlign.center,
              style: AppTextStyle.body2().copyWith(fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
