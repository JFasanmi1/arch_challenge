
import 'package:intl/intl.dart';

Object formatDatefromTimeStamp(int? timeStamp) {
  if (timeStamp == null) {
    return timeStamp.toString();
  }
  return DateTime.fromMillisecondsSinceEpoch(timeStamp!);
}

String fetchCurrentDate(String delimeter) {
  return DateFormat.yMMMEd().format(DateTime.now());
}