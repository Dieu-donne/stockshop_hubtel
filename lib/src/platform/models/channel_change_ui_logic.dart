

class ChannelsUpdateObj{
   bool showMomoField = false;
  bool showBankField = false;
  bool showOtherPaymentsField = false;
   bool showBankPayField = false;
  ChannelsUpdateObj({
    required this.showBankField,
    required this.showBankPayField,
    required this.showOtherPaymentsField,
    required this.showMomoField
});

}