import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

sealed class KurbanLanguageUtil {
  ///根据文字获取文本方向
  ///Get text direction based on text
  static TextDirection getTextDirection(String data, {bool isHtml = false}) {
    bool directionality = intl.Bidi.detectRtlDirectionality(
      data,
      isHtml: isHtml,
    );
    return directionality ? TextDirection.rtl : TextDirection.ltr;
  }
}
