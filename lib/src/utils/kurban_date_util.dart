import 'package:intl/intl.dart';

/// 日期格式工具类
/// Date format utility class
sealed class KurbanDateUtil {
  /// 基础格式化方法
  /// Basic date formatting
  static String format(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  /// 格式化为年月
  /// Format as year and month
  static String formatToMonth(DateTime date, {String pattern = 'yyyy-MM'}) {
    return DateFormat(pattern).format(date);
  }

  /// 当前日期格式化
  /// Format today's date
  static String today({String pattern = 'yyyy-MM-dd'}) {
    return format(DateTime.now(), pattern: pattern);
  }

  /// 当前时间格式化（含时分秒）
  /// Format current time (with hour, minute, second)
  static String now({String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    return format(DateTime.now(), pattern: pattern);
  }

  /// 当前月份格式化
  /// Format current month
  static String month({String pattern = 'yyyy-MM'}) {
    return format(DateTime.now(), pattern: pattern);
  }

  /// 时间戳转格式化日期
  /// Convert timestamp to formatted date
  static String fromTimestamp(int timestamp, {String pattern = 'yyyy-MM-dd'}) {
    return format(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
      pattern: pattern,
    );
  }

  /// 字符串转日期（支持常见格式）
  /// Parse string to DateTime (supports common formats)
  static DateTime? parse(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      final formats = [
        'yyyy-MM-dd',
        'yyyy/MM/dd',
        'yyyy.MM.dd',
        'yyyyMMdd',
        'dd-MM-yyyy',
        'MM/dd/yyyy',
      ];
      for (var format in formats) {
        try {
          return DateFormat(format).parse(dateString);
        } catch (_) {}
      }
      return null;
    }
  }

  /// 日期计算（添加天数）
  /// Add days to a date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// 计算日期差（天数）
  /// Calculate difference in days between two dates
  static int differenceInDays(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  /// 判断是否为今天
  /// Check if the date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// 获取月末最后一天
  /// Get the last day of the month
  static DateTime lastDayOfMonth(DateTime date) {
    // 下月1号的前一天即为本月最后一天
    // The day before the first day of next month is the last day of this month
    return DateTime(date.year, date.month + 1, 0);
  }

  /// 生成日期范围列表
  /// Generate a list of dates in a range
  static List<DateTime> generateDateRange(DateTime start, DateTime end) {
    final days = (end.difference(start).inDays).abs() + 1;
    return List.generate(days, (i) => addDays(start, i));
  }
}
