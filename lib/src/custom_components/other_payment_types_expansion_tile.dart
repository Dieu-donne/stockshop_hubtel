import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hubtel_merchant_checkout_sdk/src/ux/view_model/checkout_view_model.dart';
import '../resources/resources.dart';
import '/src/core_ui/core_ui.dart';
import '/src/utils/custom_expansion_widget.dart' as customExpansion;

import '../platform/models/models.dart';
import 'custom_components.dart';
import 'mobile_money_tile_field.dart';

class OtherPaymentExpansionTile extends StatefulWidget {
  final TextEditingController editingController;

  final TextEditingController anotherEditingController;

  bool expandOptions = false;

  String selectedAccount = "Hubtel";

  Function(Wallet) onWalletSelected;

  Function(String) onChannelChanged;

  // Function(bool) onMandateTap;
  List<Wallet> providers;

  ValueChanged<bool> onMandateTap;

  String initSelectedProvider;


  List<Wallet> wallets;

  OtherPaymentExpansionTile(
      {Key? key,
      required this.controller,
      required this.onExpansionChanged,
      required this.editingController,
      required this.isSelected,
      required this.wallets,
      required this.onWalletSelected,
      required this.anotherEditingController,
      required this.onChannelChanged,
      required this.onMandateTap,
      required this.selectedAccount,
        required this.providers,
        required this.initSelectedProvider
      })
      : super(key: key);

  final customExpansion.ExpansionTileController controller;
  final void Function(bool)? onExpansionChanged;

  final bool isSelected;

  // final double value;
  @override
  State<OtherPaymentExpansionTile> createState() =>
      _OtherPaymentExpansionTileState();
}

class _OtherPaymentExpansionTileState extends State<OtherPaymentExpansionTile> {
  late bool showHubtelWalletActions = false;

  late bool showGmoneyWalletActions = widget.initSelectedProvider.toLowerCase() == "gmoney";

  late bool showZeePayWalletActions = widget.initSelectedProvider.toLowerCase() == "zeepay";

  bool checkMarkSelected = false;

  bool openedInitially = false;


  @override
  Widget build(BuildContext context) {
    return customExpansion.ExpansionTile(
      controller: widget.controller,
      headerBackgroundColor: widget.isSelected
          ? ThemeConfig.themeColor.withOpacity(0.3)
          : Colors.transparent,
      onExpansionChanged: widget.onExpansionChanged,
      maintainState: true,
      title: Text(
        CheckoutStrings.other,
        style: AppTextStyle.body2(),
      ),
      expandedAlignment: Alignment.topLeft,
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: Dimens.paddingDefault,
        vertical: Dimens.paddingDefault,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: false,
            child: AppImageWidget.local(
              image: const AssetImage(CheckoutDrawables.hubtel_logo),
              width: Dimens.iconMedium,
              height: Dimens.iconSmall,
              boxFit: BoxFit.contain,
              borderRadius: 0,
            ),
          ),
          const SizedBox(width: Dimens.paddingDefaultSmall),
          Visibility(
            visible:
                CheckoutViewModel.channelFetch?.channels?.contains("g-money") ??
                    false,
            child: AppImageWidget.local(
              image: const AssetImage(CheckoutDrawables.g_money_logo),
              width: Dimens.iconSmall,
              height: Dimens.iconSmall,
              boxFit: BoxFit.contain,
              borderRadius: 0,
            ),
          ),
          const SizedBox(width: Dimens.paddingDefaultSmall),
          Visibility(
            visible:
                CheckoutViewModel.channelFetch?.channels?.contains("zeepay") ??
                    false,
            child: AppImageWidget.local(
              image: const AssetImage(CheckoutDrawables.zee_pay_logo),
              width: Dimens.iconSmall,
              height: Dimens.iconSmall,
              boxFit: BoxFit.contain,
              borderRadius: 0,
            ),
          ),
        ],
      ),
      leading: CustomRadioIndicator(
        isSelected: widget.isSelected,
      ),
      leadingWidth: Dimens.iconMedium,
      titleAlignment: ListTileTitleAlignment.center,
      children: [
        MobileMoneyTileField(
            showWalletAdditionTile: false,
            fieldController: widget.editingController,
            wallets: widget.providers,
            onWalletSelected: (wallet) {
              _onPaymentTypeChanged(selectedAccount: wallet.accountName ?? "");
            },
            onProviderSelected: (provider) {
              log('$provider', name: '$runtimeType');
            },
            hintText: "Provider"),
        Visibility(
            visible: false,
            child: Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Your balance on Hubtel will be debited immediately you confirm.",
                  textAlign: TextAlign.start,
                ),
              ),
            )),
        Visibility(
            visible: showGmoneyWalletActions || showZeePayWalletActions,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MobileMoneyTileField(
                  fieldController: widget.anotherEditingController,
                  wallets: widget.wallets,
                  onWalletSelected: (wallet) {
                    widget.onWalletSelected(wallet);
                  },
                  onProviderSelected: (provider) {
                    print(provider);
                  },
                  hintText: "Select Mobile Wallet"),
            )),
        Visibility(
          visible: showGmoneyWalletActions,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Checkbox(
                value: checkMarkSelected,
                onChanged: (value) {
                  widget.onMandateTap(value ?? false);
                  setState(() {
                    checkMarkSelected = value ?? false;
                  });
                }),
            Text("Use Mandate ID")
          ]),
        ),
        Visibility(
            visible: showGmoneyWalletActions,
            child: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                  "You will be required to enter your Mandate ID to confirm your transaction"),
            )),
        Visibility(
            visible: showZeePayWalletActions,
            child: Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to authorize payment",
                      style: AppTextStyle.body2()
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "1. Dial *270#",
                      style: AppTextStyle.body2(),
                    ),
                    Text(
                      "2. Select Option 8 (Account)",
                      style: AppTextStyle.body2(),
                    ),
                    Text(
                      "3. Select Option 4 (Approve Payment)",
                      style: AppTextStyle.body2(),
                    ),
                    Text(
                      "4. Enter Pin to make Payment",
                      style: AppTextStyle.body2(),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  _onPaymentTypeChanged({required String selectedAccount}) {
    //
    if (OtherAccountTypes.Hubtel.rawValue == selectedAccount) {
      widget.onChannelChanged('hubtel-gh');
      setState(() {
        // widget.selectedAccount = "Hubtel";
        showHubtelWalletActions = true;
        showGmoneyWalletActions = false;
        showZeePayWalletActions = false;
      });

      return;
    }

    if (OtherAccountTypes.GMoney.rawValue == selectedAccount) {
      widget.onChannelChanged('g-money');
      setState(() {
        // widget.selectedAccount = "GMoney";
        showHubtelWalletActions = false;
        showGmoneyWalletActions = true;
        showZeePayWalletActions = false;
      });
      return;
    }

    if (OtherAccountTypes.Zeepay.rawValue == selectedAccount) {
      setState(() {
        widget.onChannelChanged('zeepay');
        showHubtelWalletActions = false;
        showGmoneyWalletActions = false;
        showZeePayWalletActions = true;
      });

      return;
    }
  }


}
