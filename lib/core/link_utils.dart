import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/notification_service.dart';

const Set<String> foodLinkUrls = {
  'https://saba.tvu.ac.ir',
  'https://samad.app',
};

Future<void> openLink(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  try {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (ok) {
      if (foodLinkUrls.contains(url)) {
        await NotificationService.instance.onFoodLinkVisited();
      }
    } else if (context.mounted) {
      _showError(context);
    }
  } catch (_) {
    if (context.mounted) _showError(context);
  }
}

void _showError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('امکان باز کردن این لینک وجود ندارد.')),
  );
}
