import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_shortener_project/Utils/AppColors.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: Text("Full History", style: CustomTextStyles.subheading(context).copyWith(color: Colors.white),),
        backgroundColor: AppColors.brandNew,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, color: Colors.white,),
        ),
      ),
      body: allHistory.isEmpty
          ? Center(child: Text("No history found"))
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
            child: ListView.builder(
                    itemCount: allHistory.length,
                    itemBuilder: (context, index) {
            final item = allHistory[index];
            return ShortUrlCard(
              shortUrl: item.shortUrl,
              baseUrlTitle: item.webpageTitle ?? "No Title",
            );
                    },
                  ),
          ),
    );
  }
}
