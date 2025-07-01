import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  static const routeName = 'supportScreen';

  const SupportScreen({super.key});

  void _openWhatsAppChat() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/201234567890');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.helpSupport),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Icon(Icons.support_agent,
                size: 100, color: AppColors.primaryColor),
            const SizedBox(height: 20),
            Text(
              loc.contactUs,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              loc.contactUsDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _openWhatsAppChat,
              child: ListTile(
                leading: const Icon(Icons.chat, color: AppColors.primaryColor),
                title: Text(loc.chatWithUs),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              loc.faq,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: Text(loc.faqQ1),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(loc.faqA1),
                )
              ],
            ),
            ExpansionTile(
              title: Text(loc.faqQ2),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(loc.faqA2),
                )
              ],
            ),
            ExpansionTile(
              title: Text(loc.faqQ3),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(loc.faqA3),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
