import 'package:intl/intl.dart';

String formatDate(String format,DateTime dateTime){
  var dateFormat=DateFormat(format);
  return dateFormat.format(dateTime);
}