import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
import 'CommonWIdgets.dart';
import 'CustomSnackbar.dart';
import 'ShareBottomSheet.dart';

class ShortUrlCard extends StatefulWidget {
  final String shortUrl;
  final String baseUrlTitle;
  final VoidCallback onDelete;

  const ShortUrlCard({
    required Key key,
    required this.shortUrl,
    required this.baseUrlTitle,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ShortUrlCard> createState() => _ShortUrlCardState();
}

class _ShortUrlCardState extends State<ShortUrlCard> {
  bool _isSwiping = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Dismissible(
      key: widget.key!,
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.only(bottom: height * 0.01),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: width * 0.05),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: height * 0.05,
        ),
      ),
      onUpdate: (details) {
        if (details.progress > 0 && !_isSwiping) {
          setState(() {
            _isSwiping = true;
          });
        } else if (details.progress == 0 && _isSwiping) {
          setState(() {
            _isSwiping = false;
          });
        }
      },

      onDismissed: (_) {
        widget.onDelete();
      },
      onResize: () {
        // Reset after the animation completes
        if (_isSwiping) {
          setState(() {
            _isSwiping = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            topRight: Radius.circular(_isSwiping ? 0 : 8),
            bottomRight: Radius.circular(_isSwiping ? 0 : 8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.baseUrlTitle,
              style: CustomTextStyles.subtitle(context).copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => openURL(context, widget.shortUrl),
                  child: Text(
                    widget.shortUrl,
                    style: CustomTextStyles.shortUrl(context).copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.shareNodes,
                    color: AppColors.textFieldFill,
                    size: width * 0.055,
                  ),
                  onPressed: () => ShareBottomSheet.show(context, widget.shortUrl),
                  tooltip: 'Share URL',
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
