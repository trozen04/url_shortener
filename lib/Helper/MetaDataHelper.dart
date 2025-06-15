import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class MetadataHelper {
  static Future<String?> fetchPageTitle(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final titleElement = document.querySelector('title');
        return titleElement?.text ?? "No Title Found";
      } else {
        return "No Title Found";
      }
    } catch (e) {
      return "No Title Found";
    }
  }
}
