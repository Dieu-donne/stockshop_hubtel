import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../core_ui/core_ui.dart';
import '../platform/models/models.dart';
import '../resources/resources.dart';
import '../utils/utils.dart';
import '../ux/wallet/add_wallet_screen.dart';

class MobileMoneyTileField extends StatefulWidget {
  MobileMoneyTileField(
      {Key? key,
      required this.fieldController,
      this.wallets,
      this.providers,
      required this.onWalletSelected,
      required this.onProviderSelected,
      required this.hintText,
      this.onWalletUpdateComplete,
      this.showWalletAdditionTile,
      this.isReadOnly = true})
      : super(key: key);

  final TextEditingController fieldController;
  final List<Wallet>? wallets;
  final List<MomoProvider>? providers;
  final String hintText;
  final void Function(Wallet) onWalletSelected;
  final void Function(MomoProvider) onProviderSelected;
  VoidCallback? onWalletUpdateComplete;
  bool? showWalletAdditionTile = true;
  bool isReadOnly = true;

  @override
  State<MobileMoneyTileField> createState() => _MobileMoneyTileFieldState();
}

class _MobileMoneyTileFieldState extends State<MobileMoneyTileField> {
  bool expandOptions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          hasFill: true,
          hintText: widget.hintText,
          controller: widget.fieldController,
          readOnly: widget.isReadOnly,
          suffixWidget: widget.isReadOnly
              ? Padding(
                  padding:
                      const EdgeInsets.only(right: Dimens.paddingDefaultSmall),
                  child: Icon(
                    expandOptions == true
                        ? FlutterRemix.arrow_up_s_line
                        : FlutterRemix.arrow_down_s_line,
                    color: HubtelColors.neutral.shade900,
                  ),
                )
              : null,
          onTap: () {
            setState(() {
              if (widget.isReadOnly) {
                expandOptions = !expandOptions;
              }
            });
          },
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(Dimens.inputBorderRadius),
          ),
          // contentPadding: symmetricPad(
          //   horizontal: AppDimens.paddingDefault,
          // ),
        ),
        Visibility(
          visible: expandOptions,
          child: Card(
            elevation: 7,
            shadowColor: HubtelColors.neutral.shade300,
            margin: onlySidePad(
              top: Dimens.paddingMicro,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Dimens.defaultBorderRadius,
              ),
            ),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: widget.wallets != null
                    ? [
                        ...widget.wallets!.map((e) {
                          if (e.type?.toLowerCase() ==
                                  WalletType.Card.optionValue.toLowerCase() ||
                              e.type?.toLowerCase() ==
                                  WalletType.Hubtel.optionValue.toLowerCase()) {
                            return const SizedBox();
                          }
                          return ListTile(
                            onTap: () {
                              setState(() {
                                widget.fieldController.text =
                                    widget.showWalletAdditionTile ?? true
                                        ? e.accountNo ?? ""
                                        : e.accountName ?? "";
                              });
                              expandOptions = false;
                              widget.onWalletSelected(e);
                            },
                            title: Text(
                              widget.showWalletAdditionTile ?? true
                                  ? e.accountNo ?? ""
                                  : e.accountName ?? "",
                              style: AppTextStyle.body2()
                                  .copyWith(color: Colors.black),
                            ),
                            subtitle: widget.showWalletAdditionTile ?? true
                                ? Visibility(
                                    visible:
                                        widget.showWalletAdditionTile ?? true,
                                    child: Text(
                                      widget.showWalletAdditionTile ?? true
                                          ? (e.providerName).capitalize()
                                          : "",
                                      style: AppTextStyle.body2().copyWith(
                                          color: HubtelColors.neutral.shade600),
                                    ),
                                  )
                                : null,
                          );
                        }),
                        Visibility(
                          visible: widget.showWalletAdditionTile ?? true,
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                expandOptions = false;
                              });
                              _onWalletAdditionCompleted();
                            },
                            leading: Icon(
                              Icons.add_circle_outline_rounded,
                              color: ThemeConfig.themeColor,
                              size: Dimens.defaultIconNormal,
                            ),
                            title: Text(
                              CheckoutStrings.addMobileMoneyWallet,
                              style: AppTextStyle.body2().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            minLeadingWidth: Dimens.paddingNano,
                          ),
                        )
                      ]
                    : widget.providers != null
                        ? widget.providers!
                            .map(
                              (e) => ListTile(
                                onTap: () {
                                  setState(() {
                                    widget.fieldController.text = e.name ?? "";
                                  });
                                  expandOptions = false;
                                  widget.onProviderSelected(e);
                                },
                                title: Text(
                                  e.name ?? "",
                                  style: AppTextStyle.body2()
                                      .copyWith(color: Colors.black),
                                ),
                                dense: true,
                                minVerticalPadding: 0,
                              ),
                            )
                            .toList()
                        : [],
              ),
            ),
          ),
        )
      ],
    );
  }

  _onWalletAdditionCompleted() async{
    final onWalletAdded = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWalletScreen(),
      ),
    );

    if (onWalletAdded == true){
      widget.onWalletUpdateComplete?.call();
    }
  }
}
