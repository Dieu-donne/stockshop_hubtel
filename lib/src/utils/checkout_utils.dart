import '../platform/models/models.dart';
import '../resources/resources.dart';

class CheckoutUtils {
  static String mapApiWalletProviderNameToKnowName(
      {required String providerName}) {
    final nameOfProvider = providerName.toLowerCase();
    if (nameOfProvider.contains(CheckoutStrings.mtn)) {
      return CheckoutStrings.mtnMobileMoney;
    } else if (nameOfProvider.contains(CheckoutStrings.vodafone) ||
        nameOfProvider.contains("voda")) {
      return CheckoutStrings.vodafoneCash;
    } else if (nameOfProvider.contains(CheckoutStrings.airtelTigo) ||
        nameOfProvider.contains(CheckoutStrings.atMoney) ||
        nameOfProvider.contains(CheckoutStrings.airtel) ||
        nameOfProvider.contains("tigo")) {
      return CheckoutStrings.airtelTigoMoney;
    } else {
      return CheckoutStrings.mtnMobileMoney;
    }
  }

  static MomoProvider getProvider({required String providerString}) {
    if (providerString.toLowerCase().contains("mtn")) {
      return MomoProvider(
          name: "MTN",
          logoUrl: "",
          alias: "mtn-gh",
          receiveMoneyPromptValue: "mtn-gh",
          preapprovalConfirmValue: "",
          directDebitValue: "mtn-gh-direct-debit");
    }

    if (providerString.toLowerCase().contains("airtel")) {
      return MomoProvider(
          name: "Airtel Tigo",
          logoUrl: "",
          alias: "airtelTigo",
          receiveMoneyPromptValue: "tigo-gh",
          preapprovalConfirmValue: "",
          directDebitValue: "tigo-gh-direct-debit");
    }

    if (providerString.toLowerCase().contains("voda") || providerString.toLowerCase().contains("telecel")) {
      return MomoProvider(
          name: "Vodafone",
          logoUrl: "",
          alias: "vodafone",
          receiveMoneyPromptValue: "vodafone-gh",
          preapprovalConfirmValue: "",
          directDebitValue: "vodafone-gh-direct-debit");
    }

    return MomoProvider(
        name: "MTN",
        logoUrl: "",
        alias: "mtn-gh",
        receiveMoneyPromptValue: "mtn-gh",
        preapprovalConfirmValue: "",
        directDebitValue: "mtn-gh-direct-debit");
  }

  static String mapProviderNameToShortName({required String providerName}) {
    switch (providerName) {
      case CheckoutStrings.mtnMobileMoney:
        return CheckoutStrings.mtn;
      case CheckoutStrings.vodafoneCash:
        return CheckoutStrings.vodafone;
      case CheckoutStrings.airtelTigoMoney:
        return CheckoutStrings.airtelTigo;
      default:
        return "";
    }
  }
}
