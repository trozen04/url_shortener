import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  static const String _launchCountKey = 'review_launch_count';
  static const String _lastPromptKey = 'review_last_prompt';

  // Configurable values — feel free to adjust these for your production app
  static const int minLaunchesBeforePrompt = 5; // <-- more natural for real users
  static const int daysBetweenPrompts = 30; // <-- Play Store safe gap

  const ReviewService();

  /// Call this on app launch or after major user actions
  Future<void> handleReviewFlow() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      int launchCount = prefs.getInt(_launchCountKey) ?? 0;
      launchCount++;
      await prefs.setInt(_launchCountKey, launchCount);

      if (await _shouldPrompt(prefs, launchCount)) {
        await _triggerReview();
        await prefs.setInt(_launchCountKey, 0);
        await prefs.setInt(_lastPromptKey, DateTime.now().millisecondsSinceEpoch);
      }
    } catch (e) {
      // Catch any error silently to avoid crashing app in production
      print('ReviewService error: $e');
    }
  }

  Future<bool> _shouldPrompt(SharedPreferences prefs, int launchCount) async {
    if (launchCount < minLaunchesBeforePrompt) return false;

    final lastPromptTimestamp = prefs.getInt(_lastPromptKey) ?? 0;
    final lastPromptDate = DateTime.fromMillisecondsSinceEpoch(lastPromptTimestamp);
    final now = DateTime.now();
    final daysSinceLastPrompt = now.difference(lastPromptDate).inDays;

    return daysSinceLastPrompt >= daysBetweenPrompts;
  }

  Future<void> _triggerReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    }
  }

  /// Optional: Reset review counters (for QA/testing)
  static Future<void> resetCounters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_launchCountKey);
    await prefs.remove(_lastPromptKey);
  }
}
