import 'package:intl/intl.dart';

class UniversalDateParser {
  /// Precompile formats
  static final Map<String, DateFormat> _formatMap = {
    // Slash formats
    'slash': DateFormat('dd/MM/yyyy HH:mm'),
    'slash2': DateFormat('dd/MM/yyyy HH:mm:ss'),
    'slash3': DateFormat('dd/MM/yyyy'),
    'slash4': DateFormat('yyyy/MM/dd HH:mm:ss'),
    'slash5': DateFormat('yyyy/MM/dd HH:mm'),
    'slash6': DateFormat('yyyy/MM/dd'),

    // Dash formats
    'dash': DateFormat('yyyy-MM-dd HH:mm:ss'),
    'dash2': DateFormat('yyyy-MM-dd HH:mm'),
    'dash3': DateFormat('yyyy-MM-dd'),
    'dash4': DateFormat('dd-MM-yyyy HH:mm:ss'),
    'dash5': DateFormat('dd-MM-yyyy HH:mm'),
    'dash6': DateFormat('dd-MM-yyyy'),

    // Text formats
    'text': DateFormat('dd MMM yyyy'),
    'text2': DateFormat('dd MMM yyyy HH:mm'),
    'text3': DateFormat('dd MMM yyyy HH:mm:ss'),
    'text4': DateFormat('MMM dd, yyyy'),
    'text5': DateFormat('MMM dd, yyyy HH:mm'),
    'text6': DateFormat('MMM dd, yyyy HH:mm:ss'),

    // Compact
    'compact': DateFormat('yyyyMMdd'),
    'compact2': DateFormat('yyyyMMddHHmmss'),
    'compact3': DateFormat('yyyyMMddHHmm'),

    // RFC formats (Z expects +0530 format without colon)
    'rfc': DateFormat('EEE, dd MMM yyyy HH:mm:ss Z'),
    'rfc2': DateFormat('EEE, dd MMM yyyy HH:mm:ss'),
  };

  /// Fix timezone formats like +05:30 → +0530 (remove colon for Z pattern)
  String _normalizeRfcTimezone(String input) {
    // Pattern to match timezone with colon: +05:30 or -05:30
    final regex = RegExp(r'([+-])(\d{2}):(\d{2})$');
    final match = regex.firstMatch(input);
    if (match != null) {
      final sign = match.group(1);
      final h = match.group(2);
      final m = match.group(3);
      return input.replaceAll(match.group(0)!, "$sign$h$m");
    }
    return input;
  }

  /// Normalize RFC date string for case-insensitive parsing
  String _normalizeRfcCase(String input) {
    // List of day and month abbreviations
    final days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
    final months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec',
    ];

    String result = input;

    // Capitalize day names (e.g., mon → Mon)
    for (final day in days) {
      final regex = RegExp(day, caseSensitive: false);
      result = result.replaceAllMapped(regex, (match) {
        return match.group(0)![0].toUpperCase() +
            match.group(0)!.substring(1).toLowerCase();
      });
    }

    // Capitalize month names (e.g., nov → Nov)
    for (final month in months) {
      final regex = RegExp(month, caseSensitive: false);
      result = result.replaceAllMapped(regex, (match) {
        return match.group(0)![0].toUpperCase() +
            match.group(0)!.substring(1).toLowerCase();
      });
    }

    return result;
  }

  /// Detect formats
  List<DateFormat> _detectFormats(String s) {
    if (RegExp(r'^\d+$').hasMatch(s)) {
      return _formatMap.entries
          .where((e) => e.key.contains('compact'))
          .map((e) => e.value)
          .toList();
    }

    // RFC (Mon, / Monday,)
    if (RegExp(r'^[A-Za-z]+,').hasMatch(s)) {
      return [_formatMap['rfc']!, _formatMap['rfc2']!];
    }

    if (s.contains('/')) {
      return _formatMap.entries
          .where((e) => e.key.contains('slash'))
          .map((e) => e.value)
          .toList();
    }

    if (s.contains('-') &&
        !RegExp(r'[A-Za-z]').hasMatch(s) &&
        !s.contains(',')) {
      return _formatMap.entries
          .where((e) => e.key.contains('dash'))
          .map((e) => e.value)
          .toList();
    }

    if (RegExp(r'[A-Za-z]').hasMatch(s)) {
      return _formatMap.entries
          .where((e) => e.key.contains('text'))
          .map((e) => e.value)
          .toList();
    }

    return _formatMap.values.toList();
  }

  /// Core parser
  String _tryParseAndFormatDate(String input, String outputFormat) {
    final outFmt = DateFormat(outputFormat);

    // ISO first
    final iso = DateTime.tryParse(input);
    if (iso != null) return outFmt.format(iso);

    // Track if this is an RFC format
    final isRfc = RegExp(r'^[A-Za-z]+,').hasMatch(input);

    // Normalize RFC before detection & parsing
    if (isRfc) {
      input = _normalizeRfcCase(input);
      input = _normalizeRfcTimezone(input);
    }

    final candidates = _detectFormats(input);

    // For RFC formats, use parse() instead of parseStrict() because
    // timezone patterns (Z, z) don't work with parseStrict()
    for (final fmt in candidates) {
      try {
        final parsed = isRfc ? fmt.parse(input) : fmt.parseStrict(input);
        return outFmt.format(parsed);
      } catch (_) {}
    }

    // fallback
    for (final entry in _formatMap.entries) {
      try {
        final parsed = isRfc
            ? entry.value.parse(input)
            : entry.value.parseStrict(input);
        return outFmt.format(parsed);
      } catch (_) {}
    }

    return "Invalid date";
  }

  /// Public API
  String formatDate({
    required String date,
    String outputDateFormat = 'dd/MM/yyyy HH:mm',
  }) {
    return _tryParseAndFormatDate(date, outputDateFormat);
  }
}
