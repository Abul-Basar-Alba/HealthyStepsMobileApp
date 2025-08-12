import 'package:intl/intl.dart'; // Already present, but ensured

class Formatters {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatCalories(int calories) {
    return '$calories cal';
  }
}