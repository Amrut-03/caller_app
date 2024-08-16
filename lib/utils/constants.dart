// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class AppTemplate {
  static messenger(BuildContext context, String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  static void openWhatsapp({
    required BuildContext context,
    required String text,
    required String number,
  }) async {
    final whatsappURL =
        'https://wa.me/$number?text=${Uri.encodeComponent(text)}';

    if (await canLaunch(whatsappURL)) {
      await launch(whatsappURL);
    } else {
      messenger(context, "WhatsApp not installed or unable to launch URL");
    }
  }

  Future<void> dial(BuildContext context, String phone) async {
    PermissionStatus status = await Permission.phone.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      final Uri callUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        messenger(context, 'Could not place the call.');
      }
    } else if (status.isDenied) {
      messenger(context, 'Phone permission is required to make a call.');
    } else if (status.isPermanentlyDenied) {
      messenger(context,
          'Phone permission is permanently denied. Please enable it in settings.');
      openAppSettings();
    }
  }
}
