import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiServices/UrlHistoryModel.dart';

class HistoryHelper {
  static const String _key = 'url_history';

  static Future<void> saveUrl(UrlHistoryModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getStringList(_key) ?? [];
    existingData.insert(0, jsonEncode(model.toJson()));  // latest on top
    await prefs.setStringList(_key, existingData);
  }

  static Future<List<UrlHistoryModel>> getUrls({int offset = 0, int limit = 20}) async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getStringList(_key) ?? [];
    final paginated = existingData.skip(offset).take(limit).toList();
    return paginated.map((e) => UrlHistoryModel.fromJson(jsonDecode(e))).toList();
  }

  static Future<List<UrlHistoryModel>> getAllUrls() async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getStringList(_key) ?? [];
    return existingData.map((e) => UrlHistoryModel.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  // Add this to HistoryHelper
  static Future<void> updateAllHistory(List<UrlHistoryModel> updatedList) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = updatedList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, encodedList);
  }

}
