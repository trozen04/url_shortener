import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
import 'CommonWIdgets.dart';
import 'CustomSnackbar.dart';

class ShortUrlCard extends StatelessWidget {
  final String shortUrl;
  final String baseUrlTitle;  // 🔥 NEW FIELD: Title we extracted

  const ShortUrlCard({
    super.key,
    required this.shortUrl,
    required this.baseUrlTitle,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
      margin: EdgeInsets.only(bottom: height * 0.01),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonShadow.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Title Section (New)
          Text(
            baseUrlTitle,
            style: CustomTextStyles.subtitle(context).copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => openURL(context, shortUrl),
                child: Text(
                  shortUrl,
                  style: CustomTextStyles.shortUrl(context).copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
        ],
      ),
    );
  }
}
