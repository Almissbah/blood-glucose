import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateTimeUtils {
  static showDatePicker(BuildContext context,
      {Function(DateTime) onChanged,
      Function(DateTime) onConfirm,
      DateTime minTime,
      DateTime maxTime,
      DateTime currentTime,
      Locale locale}) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: minTime ?? DateTime.now().subtract(Duration(days: 360)),
      maxTime: maxTime ?? DateTime.now().add(Duration(days: 360)),
      onChanged: onChanged,
      onConfirm: onConfirm,
      currentTime: currentTime ?? DateTime.now(),
    );
  }

  static String formatDate(DateTime dateTime) {
    try {
      final df = new DateFormat('yyyy-MM-dd');
      return df.format(dateTime);
    } catch (e) {
      return "";
    }
  }
}
