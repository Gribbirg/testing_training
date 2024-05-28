import 'package:url_launcher/url_launcher.dart';

Future<void> goToUrl(String url) async {
  final uri = Uri.parse(url);
  if (!(await launchUrl(uri))) {
    throw 'Could not launch $url';
  }
}
