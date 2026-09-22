/// Shared display formatting. South African Rand amounts use a space thousands
/// separator (R2 500.00) and dates the short "01 Feb 2026" form used by the owner.
class AppFormat {
  AppFormat._();

  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const List<String> _shortMonths = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String money(num amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final digits = parts[0];
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) buffer.write(' ');
    }
    return 'R$buffer.${parts[1]}';
  }

  static String perMonth(num amount) => '${money(amount)} / month';

  static String date(DateTime value) =>
      '${value.day.toString().padLeft(2, '0')} ${_shortMonths[value.month - 1]} ${value.year}';

  static String longDate(DateTime value) =>
      '${value.day.toString().padLeft(2, '0')} ${_months[value.month - 1]} ${value.year}';

  static String monthYear(DateTime value) => '${_months[value.month - 1]} ${value.year}';
}
