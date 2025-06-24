import 'package:flutter/material.dart';
import 'package:url_shortener_project/Utils/FFontStyles.dart';

class ClearHistoryDialog extends StatelessWidget {
  const ClearHistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 50),
            const SizedBox(height: 10),
            Text(
              "Clear History?",
              style: CustomTextStyles.title(context),
            ),
            const SizedBox(height: 10),
            Text(
              "This action will permanently delete your entire URL history.",
              textAlign: TextAlign.center,
              style: CustomTextStyles.subheading(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Cancel", style: CustomTextStyles.subtitle(context),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Delete", style: CustomTextStyles.subtitle(context).copyWith(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
