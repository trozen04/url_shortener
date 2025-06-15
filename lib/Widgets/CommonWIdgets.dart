import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';

import 'CustomSnackbar.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.brandNew, size: 20),
          title: Text(title, style: CustomTextStyles.body(context)),
          onTap: onTap,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.textfieldborder, // Or use a theme color if preferred
        ),
      ],
    );
  }
}


class NavigationUtils {
  static Route slideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}


void openURL(BuildContext context, String urlString) async {
  if (urlString.isEmpty || urlString.trim().isEmpty) {
    CustomSnackbar.show(context, message: 'URL is empty', isSuccess: false);
    return;
  }

  String cleanedUrl = urlString.trim();
  if (!cleanedUrl.startsWith('http://') && !cleanedUrl.startsWith('https://')) {
    cleanedUrl = 'https://$cleanedUrl';
  }

  try {
    final Uri url = Uri.parse(cleanedUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      CustomSnackbar.show(context, message: 'Could not launch URL', isSuccess: false);
    }
  } catch (e) {
    CustomSnackbar.show(context, message: 'Invalid URL: $e', isSuccess: false);
  }
}
