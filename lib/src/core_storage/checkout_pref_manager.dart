import '../platform/models/models.dart';
import 'base_pref_manager.dart';
import 'pref_constants.dart';

class CheckoutPrefManager extends BasePrefManager {
  set mandateId(String value) {
    saveToSharedPref(PrefConstants.MANDATE_ID_KEY, value);
  }

  Future<String?> getMandateId() async {
    return await getSharedPrefString(PrefConstants.MANDATE_ID_KEY);
  }

  Future<void> saveBankWallet(BankCardData? card) async {
    final savedCards = await getBankCards();
    final found = savedCards?.firstWhere((element) => element.cardNumber == card?.cardNumber, orElse: () => BankCardData());
    if (found?.cardNumber == card?.cardNumber) {
      found?.cvv = card?.cvv;
      found?.cardExpiryDate = card?.cardExpiryDate;
      savedCards?.remove(found);
      savedCards?.add(found!);
    } else {
      savedCards?.add(card!);
    }
    saveToSharedPrefObjectList(PrefConstants.BANK_CARD_ID_KEY, savedCards);
  }

  Future<List<BankCardData>>? getBankCards() async {
    final parsedJson =
        await getSharedPrefObjectList(PrefConstants.BANK_CARD_ID_KEY);
    if (parsedJson == null) return [];
    return parsedJson.map((e) => BankCardData.fromJson(e)).toList();
  }

}
