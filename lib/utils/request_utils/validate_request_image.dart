import 'package:http/http.dart' as http;


Future<bool> validateImageLink(String value) async {
  try {
    // Try to fetch the image and check if it's a valid link
    final response = await http.head(Uri.parse(value));
    if (response.statusCode == 200) {
      // Image link is valid
      return true;
    } else {
      // Image link is not valid
      return false;
    }
  } catch (e) {
    // If an exception occurs (e.g., ImageCodecException), return false
    return false;
  }
}