import 'package:flutter/material.dart';

import '../../core_ui/core_ui.dart';
import '../../resources/checkout_colors.dart';

class HBButton extends StatelessWidget {
  const HBButton({super.key, required this.label, required this.onPressed});

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // height: 56.0,
      minWidth: double.infinity,
      // TODO: verify elevation and shadow behavior on click
      elevation: 0.0,
      onPressed: () => onPressed(),
      color: CheckoutColors.defaultGreenColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, bottom: 12.0, left: 32.0, right: 32.0),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: Dimens.font16sp,
            color: CheckoutColors.defaultWhiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
