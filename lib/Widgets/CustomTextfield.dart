import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.textFieldFill,
        borderRadius: BorderRadius.circular(width * 0.03),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonShadow.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Prefix Icon
          Container(
            width: width * 0.12,
            height: height * 0.07,
            alignment: Alignment.center,
            child: FaIcon(
              FontAwesomeIcons.link,
              color: AppColors.textPrimary,
              size: width * 0.06,
            ),
          ),
          // Text Input
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.url,
              style: CustomTextStyles.textFieldInput(context),
              cursorColor: AppColors.textHighlight,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: CustomTextStyles.textFieldHint(context),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}