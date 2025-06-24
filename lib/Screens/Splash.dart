import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Utils/ImageAssets.dart';
import 'Homepage.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onAppStart;
  const SplashScreen({super.key, this.onAppStart});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  static const platform = MethodChannel('app.channel.shared.data');
  String? sharedText;

  @override
  void initState() {
    super.initState();
    widget.onAppStart?.call();
    getSharedText();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(sharedText: sharedText),
        ),
      );
    });
  }


  Future<void> getSharedText() async {
    try {
      final result = await platform.invokeMethod<String>('getSharedText');
      if (result != null && result.isNotEmpty) {
        setState(() {
          sharedText = result;
        });
      }
    } on PlatformException catch (e) {
      print("Error retrieving shared text: ${e.message}");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Image.asset(ImageAssets.appIcon),
      ),
    );
  }
}