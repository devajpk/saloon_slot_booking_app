import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static Future<void> launchUrlString(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      _showError(context, 'Invalid URL');
      return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showError(context, 'Could not launch $url');
    }
  }

  static Future<void> callNumber(BuildContext context, String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showError(context, 'Could not make a call');
    }
  }

  static Future<void> sendEmail(BuildContext context, String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showError(context, 'Could not send email');
    }
  }

  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
