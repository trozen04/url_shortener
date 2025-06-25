import 'dart:convert';
import 'dart:developer' as developer;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Utils/Constants.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
import 'package:url_shortener_project/Widgets/BannerAdWidget.dart';
import 'package:url_shortener_project/Widgets/CustomPopUp.dart';
import 'package:url_shortener_project/Widgets/CustomSnackbar.dart';
import '../Helper/HistoryHelper.dart';
import '../ApiServices/UrlHistoryModel.dart';
import '../Widgets/ShortUrlCard.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<UrlHistoryModel> allHistory = [];
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await HistoryHelper.getAllUrls();
    setState(() {
      allHistory = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Full History",
                style: CustomTextStyles.subheading(context).copyWith(color: Colors.white),
              ),
              backgroundColor: AppColors.brandNew,
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(CupertinoIcons.back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                if(allHistory.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                  onPressed: () async {
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => const ClearHistoryDialog(),
                    );

                    if (shouldDelete == true) {
                      await HistoryHelper.clearHistory();
                      setState(() {
                        allHistory.clear();
                      });
                    }
                  },
                ),
                SizedBox(width: width * 0.035,)
              ],
            ),
            body: allHistory.isEmpty
                ? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.manage_history_outlined, size: width * 0.4, color: AppColors.greyText),
                    SizedBox(height: height * 0.02,),
                    Text("No history found", style: CustomTextStyles.subheading(context),),
                  ],
                ))
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
                  child: ListView.builder(itemCount: allHistory.length,

                      itemBuilder: (context, index) {
                        final item = allHistory[index];

                        return ShortUrlCard(
                          key: Key(item.shortUrl),
                          shortUrl: item.shortUrl,
                          baseUrlTitle: item.webpageTitle ?? "No Title",
                          onDelete: () async {
                            setState(() {
                              allHistory.removeWhere((element) => element.shortUrl == item.shortUrl);
                            });
                            await HistoryHelper.updateAllHistory(allHistory);
                          },

                        );
                      }


                  ),
                ),
          ),
        ),
        const BannerAdWidget(),
      ],
    );
  }
}
