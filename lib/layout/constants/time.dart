import 'package:intl/intl.dart';

class Time {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');

  String todayDate() {
    return formatter.format(now);
  }
}
