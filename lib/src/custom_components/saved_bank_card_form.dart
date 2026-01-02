
import 'package:flutter/material.dart';
import '/src/custom_components/custom_components.dart';
import '/src/platform/models/models.dart';

import '../resources/checkout_strings.dart';

class SavedBankCardForm extends StatefulWidget {
  const SavedBankCardForm({
    super.key,
    required this.cardNumberFieldController,
    required this.cards,
    required this.onCardSelected,
    required this.onCvvChanged,
    required this.formKey,
  });

  final TextEditingController cardNumberFieldController;
  final void Function(BankCardData) onCardSelected;
  final List<BankCardData> cards;
  final void Function(String)? onCvvChanged;
  final GlobalKey<FormState> formKey;

  @override
  State<SavedBankCardForm> createState() => _SavedBankCardFormState();
}

class _SavedBankCardFormState extends State<SavedBankCardForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          BankTileDropdown(
            fieldController: widget.cardNumberFieldController,
            cards: widget.cards,
            hintText: CheckoutStrings.bankCard,
            onCardSelected: widget.onCardSelected,
          ),

        ],
      ),
    );
  }
}
