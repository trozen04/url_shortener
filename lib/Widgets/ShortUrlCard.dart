import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ for launching URL
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';

import 'CommonWIdgets.dart';
import 'CustomSnackbar.dart';

class ShortUrlCard extends StatelessWidget {
  final String shortUrl;

  const ShortUrlCard({
    super.key,
    required this.shortUrl,
  });


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonShadow.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.015),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => openURL(context, shortUrl),
                child: Text(
                  shortUrl,
                  style: CustomTextStyles.shortUrl(context).copyWith(
                    color: Colors.blue, // 🔵 Makes it look clickable
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(width: width * 0.02),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.copy,
                color: AppColors.textFieldFill,
                size: width * 0.055,
              ),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: shortUrl));
                CustomSnackbar.show(context, message: 'Copied to clipboard!', isSuccess: true);
              },
              tooltip: 'Copy URL',
            ),
          ],
        ),
      ),
    );
  }

}
