import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Widgets/CustomSnackbar.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareBottomSheet {
  static void show(BuildContext context, String url) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: AppColors.cardBackground,
      builder: (_) => Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Share via", style: CustomTextStyles.subtitle(context).copyWith(color: Colors.white)),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShareIcon(context, FontAwesomeIcons.copy, "Copy", () async {
                  await Clipboard.setData(ClipboardData(text: url));
                  Navigator.pop(context); // Close bottom sheet
                  CustomSnackbar.show(context, message: 'Copied to clipboard!', isSuccess: true);
                }),
                _buildShareIcon(context, FontAwesomeIcons.whatsapp, "WhatsApp", () async {
                  final encoded = Uri.encodeComponent(url);
                  final whatsappUrl = Uri.parse("https://wa.me/?text=$encoded");

                  if (await canLaunchUrl(whatsappUrl)) {
                    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
                  } else {
                    CustomSnackbar.show(context, message: 'Could not open WhatsApp', isSuccess: false);
                  }
                }),

                _buildShareIcon(context, FontAwesomeIcons.facebookF, "Facebook", () async {
                  final encoded = Uri.encodeComponent(url);
                  final facebookUrl = Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$encoded");

                  if (await canLaunchUrl(facebookUrl)) {
                    await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
                  } else {
                    CustomSnackbar.show(context, message: 'Could not open Facebook', isSuccess: false);
                  }
                }),

                _buildShareIcon(context, FontAwesomeIcons.envelope, "Gmail", () async {
                  final emailUri = Uri(
                    scheme: 'mailto',
                    queryParameters: {
                      'subject': 'Check out this URL',
                      'body': url,
                    },
                  );

                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri);
                  } else {
                    CustomSnackbar.show(context, message: 'Could not open Gmail', isSuccess: false);
                  }
                }),

              ],
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  static Widget _buildShareIcon(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: MediaQuery.of(context).size.height * 0.025,
            child: FaIcon(icon, color: AppColors.primary, size: MediaQuery.of(context).size.height * 0.025),
          ),
          SizedBox(height: 6),
          Text(label, style: CustomTextStyles.shortUrl(context)),
        ],
      ),
    );
  }
}
