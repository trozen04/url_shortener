import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_shortener_project/ApiServices/shrink_zap_bloc.dart';
import 'package:url_shortener_project/Utils/ImageAssets.dart';
import 'package:url_shortener_project/Widgets/CustomSnackbar.dart';
import 'package:url_shortener_project/Widgets/CustomTextField.dart';
import 'package:url_shortener_project/Widgets/ShortUrlCard.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_project/Widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String? _shortUrl;
  bool _loading = false;
  Map<String, dynamic> responseData = {};

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return BlocListener<ShrinkZapBloc, ShrinkZapState>(
  listener: (context, state) {
    if(state is ShrinkZapLoading) {
      setState(() {
        _loading = true;
      });
    } else if (state is ShrinkZapSuccess) {
      setState(() {
        _loading = false;
        responseData = state.responseData;
        _shortUrl = responseData['shorturl'];
        _controller.clear();
      });
      CustomSnackbar.show(context, message: state.message, isSuccess: true,);
    } else if(state is ShrinkZapError) {
      developer.log('error: ${state.message}');
      setState(() {
        _loading = false;
      });
      CustomSnackbar.show(context, message: state.message, isSuccess: false);
    }
  },
  child: GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      backgroundColor: Colors.white,
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.035,
              vertical: height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo or Icon
                Image.asset(ImageAssets.appIcon, height: height * 0.2),
                // Subtitle
                Text(
                  'Shorten your links in a snap!',
                  style: CustomTextStyles.subtitle(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.01),
                // Input Card
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.035,
                      vertical: height * 0.015,
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _controller,
                          hintText: 'Paste your long URL here',
                        ),
                        SizedBox(height: height * 0.02),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: ElevatedButton.icon(
                            onPressed: _loading
                                ? null
                                : () {
                              final urlText = _controller.text.trim();
                              if (urlText.isEmpty) {
                                CustomSnackbar.show(context, message: 'Please enter a URL', isSuccess: false,);
                              } else {
                                context.read<ShrinkZapBloc>().add(
                                  ShrinkZapEventHandler(url: urlText),
                                );
                              }
                            },
                            icon: _loading
                                ? SizedBox(
                              height: height * 0.025,
                              width: height * 0.025,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.textFieldFill,
                              ),
                            )
                                : FaIcon(FontAwesomeIcons.arrowRight, size: width * 0.06, color: AppColors.textFieldFill,),
                            label: Text(
                              _loading ? 'Shortening...' : 'Shrink It!',
                              style: CustomTextStyles.button(context),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.textPrimary,
                              padding: EdgeInsets.symmetric(
                                horizontal:  width * 0.05,
                                vertical: height * 0.01,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(width * 0.03),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                // Result Card
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: _shortUrl != null
                      ? ShortUrlCard(
                    key: ValueKey(_shortUrl),
                    shortUrl: _shortUrl!,
                  )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
  ),
);
  }
}