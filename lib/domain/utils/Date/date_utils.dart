import 'package:intl/intl.dart';

class APPDateUtils {
  static String formatTimestamp({required String timestamp}) {
    // Parse the timestamp string to a DateTime object
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the DateTime to the desired format
    return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
  }
}
