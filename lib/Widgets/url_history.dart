import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UrlHistoryHelper {
  static const String _recentKey = 'url_history';
  static const String _fullKey = 'full_url_history';

  static Future<void> saveUrl(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    /// Save to recent (only latest 10)
    List<String> recentList = prefs.getStringList(_recentKey) ?? [];
    recentList.insert(0, jsonEncode(data));
    if (recentList.length > 10) {
      recentList = recentList.sublist(0, 10);
    }
    await prefs.setStringList(_recentKey, recentList);

    /// Save to full history (no limit)
    List<String> fullList = prefs.getStringList(_fullKey) ?? [];
    fullList.insert(0, jsonEncode(data));
    await prefs.setStringList(_fullKey, fullList);
  }
}
