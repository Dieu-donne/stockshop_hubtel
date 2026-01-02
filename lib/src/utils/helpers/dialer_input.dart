import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  static void launchDialer({required String number}) async {
    var url = "tel:$number";
    await canLaunchUrl(Uri.parse(url))
        ? await launchUrl(Uri.parse(url))
        : throw 'Could not launch $url';
  }
}