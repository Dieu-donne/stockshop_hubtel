import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hubtel_merchant_checkout_sdk/src/core_ui/core_ui.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class OtpInput extends StatefulWidget {
  final int length; // Number of OTP digits
  final ValueChanged<String> onSubmit;

  // Callback when OTP is submitted
  // final String otpInput;
  double? inactiveborderSide;
  Color? filledBackgroud;
  Color? inactiveBorderColor;
  bool? clearText;

  OtpInput({
    Key? key,
    // required this.otpInput,
    required this.length,
    required this.onSubmit,
    this.inactiveborderSide,
    this.filledBackgroud,
    this.inactiveBorderColor,
    this.clearText,
  }) : super(key: key);

  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clearText == true) {
      _pinController.clear();
      _pinFocusNode.unfocus();
    }

    final defaultPinTheme = PinTheme(
      width: 64,
      height: 64,
      textStyle: AppTextStyle.body2().copyWith(
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: widget.filledBackgroud ?? HubtelColors.greyBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimens.inputBorderRadius),
        ),
        border: Border.all(
          width: widget.inactiveborderSide ?? Dimens.zero,
          color: widget.inactiveBorderColor ?? HubtelColors.greyBackground,
        ),
      ),
    );

    return Pinput(
      length: widget.length,
      controller: _pinController,
      focusNode: _pinFocusNode,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(
            width: Dimens.lgBorderThickness,
            color: HubtelColors.teal,
          ),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(
            width: Dimens.lgBorderThickness,
            color: HubtelColors.errorColor,
          ),
        ),
      ),
      onCompleted: (pin) {
        widget.onSubmit(pin);
      },
      separatorBuilder: (index) => const SizedBox(width: Dimens.paddingDefault),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("([0-9])")),
      ],
      autofocus: true,
      smsRetriever: MySmsRetriever(),
      autofillHints: const [AutofillHints.oneTimeCode],  // For iOS quick fill
      // smsRetriever: MySmsRetriever(),  // Uncomment and implement for Android if needed
    );
  }
}

class MySmsRetriever implements SmsRetriever {
  final SmartAuth _smartAuth = SmartAuth.instance;

  @override
  Future<String?> getSmsCode() async {
    // Optional: Get and print app signature (send this hash to backend for SMS Retriever API)
    final signature = await _smartAuth.getAppSignature();
    print('App Signature for SMS Retriever: $signature');

    // Preferred: User Consent API (prompts user to approve SMS — no hash needed)
    final res = await _smartAuth.getSmsWithUserConsentApi();

    if (res.hasData && res.data?.code != null) {
      return res.data!.code;
    }

    // Optional fallback: Retriever API (no prompt, but requires app hash in SMS)
    // final retrieverRes = await _smartAuth.getSmsWithRetrieverApi();
    // if (retrieverRes.hasData && retrieverRes.data?.code != null) {
    //   return retrieverRes.data!.code;
    // }

    return null;
  }

  @override
  Future<void> dispose() async {
    // Clean up listeners (User Consent API)
    await _smartAuth.removeUserConsentApiListener();

    // If using Retriever API fallback, also call:
    // await _smartAuth.removeSmsRetrieverApiListener();
  }

  @override
  bool get listenForMultipleSms => false; // Set true if expecting multiple OTPs
}