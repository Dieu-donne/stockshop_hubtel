import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core_ui/core_ui.dart';
import '../../resources/checkout_colors.dart';

class ConfirmationCard extends StatelessWidget {
  const ConfirmationCard({
    super.key,
    required this.isRich,
    required this.icon,
    required this.backgroundColor,
    this.message,
    this.colorMessage,
    this.summary,
  });

  final String icon;
  final Color? backgroundColor;
  final String? summary;
  final String? message;
  final String? colorMessage;
  final bool isRich;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(icon),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Center(
                child: Text(
              '$summary',
              style: AppTextStyle.body2(),
            )),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: _buildMessageText(isRich),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMessageText(bool isRich) {
    if (isRich) {
      assert(colorMessage != null);
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: message),
            TextSpan(
              text: colorMessage,
              style: const TextStyle(
                color: CheckoutColors.successTextColor,
              ),
            ),
          ],
        ),
      );
    }

    assert(colorMessage == null);
    return Text(
      '$message',
      style: AppTextStyle.body2(),
    );
  }
}
