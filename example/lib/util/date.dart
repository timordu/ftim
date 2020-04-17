class DateUtil {
  DateUtil._();

  ///获取当前时间的DateTime
  static DateTime get currentTime => DateTime.now();

  ///获取当前时间的int值
  static int get milliSeconds => currentTime.millisecondsSinceEpoch;

  ///格式化当前时间
  static String formatNow({String format = 'yyyy-MM-dd HH:mm:ss'}) {
    return formatDateTime(currentTime, format: format);
  }

  ///判断日期是否是今天
  static bool isToday(String date, {String format = 'yyyy-MM-dd'}) {
    String now = formatNow(format: format);
    return date == now;
  }

  ///根据毫秒数获取DateTime
  static DateTime parseInt(int milliSeconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  }

  ///根据字符串获取DateTime
  static DateTime parseStr(String str) => DateTime.parse(str);

  ///获取日期当月有多少天
  static int dayByMonth(DateTime dt) {
    var d1 = DateTime(dt.year, dt.month, 1);
    var d2 = DateTime(dt.year, dt.month + 1, 1);
    var diff = d1.difference(d2);
    return diff.inDays.abs();
  }

  ///返回日期是星期几,默认返回数字,ch为true时返回中文
  static dynamic dayOfWeek(DateTime datetime, {bool ch = false}) {
    var chs = ['一', '二', '三', '四', '五', '六', '日'];
    if (ch) {
      return chs[datetime.weekday - 1];
    }
    return datetime.weekday;
  }

  ///根据format格式化milliSeconds,默认format为yyyy-MM-dd HH:mm:ss
  static String formatMicroseconds(int milliSeconds, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    return formatDateTime(parseInt(milliSeconds), format: format);
  }

  ///根据format格式化DateTime,默认format为yyyy-MM-dd HH:mm:ss
  static String formatDateTime(DateTime datetime, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    String formatStr = format;
    //year
    formatStr = _replace(formatStr, format, 'y', datetime.year);
    //month
    formatStr = _replace(formatStr, format, 'M', datetime.month);
    //day
    formatStr = _replace(formatStr, format, 'd', datetime.day);
    //hour
    formatStr = _replace(formatStr, format, 'H', datetime.hour);
    //minute
    formatStr = _replace(formatStr, format, 'm', datetime.minute);
    //second
    formatStr = _replace(formatStr, format, 's', datetime.second);
    //milliSeconds
    formatStr = _replace(formatStr, format, 'S', datetime.millisecond);

    return formatStr;
  }

  static String _replace(String formatStr, String format, String char, int date) {
    int num = 0;
    format.split('').forEach((str) {
      if (str == char) num++;
    });
    var replace;
    if (num > 0) {
      switch (char) {
        case 'y':
          replace = num == 2 ? '$date'.substring(2, 4) : '$date';
          break;
        case 'S':
          replace = '$date';
          break;
        default:
          replace = num == 1 ? '$date' : '$date'.padLeft(2, '0');
          break;
      }
    }
    if (replace != null) formatStr = formatStr.replaceAll(char * num, replace);
    return formatStr;
  }
}
