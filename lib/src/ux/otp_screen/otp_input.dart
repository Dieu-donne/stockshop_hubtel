
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hubtel_merchant_checkout_sdk/src/core_ui/core_ui.dart';

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
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    // Create TextEditingController for each OTP digit
    for (int i = 0; i < widget.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose the TextEditingController instances
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.clearText == true){
      for (var element in controllers) {
        element.clear();
        FocusScope.of(context).previousFocus();
        FocusScope.of(context).previousFocus();
      }

    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(widget.length, (index) {
        return Expanded(
          child: Container(
              width: 64,
              height: 64,
              margin: const EdgeInsets.only(
                right: Dimens.paddingDefault,
              ),
              child: TextField(
                controller: controllers[index],
                keyboardType: TextInputType.number,
                style: AppTextStyle.body2().copyWith(
                  fontWeight: FontWeight.bold,
                ),
                autofocus: true,
                maxLength: 1,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("([0-9])")),
                ],
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    // Move focus to the next OTP field
                    if (index < widget.length - 1) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      // Submit the OTP when the last field is filled
                      String otp = '';
                      for (var controller in controllers) {
                        otp += controller.text;
                      }
                      widget.onSubmit(otp);
                    }
                  } else {
                    // Clear the OTP field when emptied
                    if (index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  }
                },
                decoration: InputDecoration(
                  hintText: "•",
                  hintStyle: AppTextStyle.body2().copyWith(
                    color: HubtelColors.grey.shade500,
                    fontSize: Dimens.smFontSize,
                  ),
                  filled: true,
                  fillColor:
                  widget.filledBackgroud ?? HubtelColors.greyBackground,
                  counterText: "",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        Dimens.inputBorderRadius,
                      ),
                    ),
                    borderSide: BorderSide(
                      width: Dimens.zero,
                      color: HubtelColors.greyBackground,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        Dimens.inputBorderRadius,
                      ),
                    ),
                    borderSide: BorderSide(
                      width: widget.inactiveborderSide ?? Dimens.zero,
                      color: widget.inactiveBorderColor ??
                          HubtelColors.greyBackground,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        Dimens.inputBorderRadius,
                      ),
                    ),
                    borderSide: BorderSide(
                      width: Dimens.lgBorderThickness,
                      color: HubtelColors.teal,
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }
}

