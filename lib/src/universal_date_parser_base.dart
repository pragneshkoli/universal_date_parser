import 'package:intl/intl.dart';

class UniversalDateParser {
  /// Precompiled formats map for direct access and fallback
  static final Map<String, DateFormat> _formatMap = {
    // Slash formats (International & US, 4 & 2 digit years)
    'slash': DateFormat('dd/MM/yyyy HH:mm'),
    'slash2': DateFormat('dd/MM/yyyy HH:mm:ss'),
    'slash3': DateFormat('dd/MM/yyyy'),
    'slash4': DateFormat('yyyy/MM/dd HH:mm:ss'),
    'slash5': DateFormat('yyyy/MM/dd HH:mm'),
    'slash6': DateFormat('yyyy/MM/dd'),
    'slash7': DateFormat('dd/MM/yy HH:mm:ss'),
    'slash8': DateFormat('dd/MM/yy HH:mm'),
    'slash9': DateFormat('dd/MM/yy'),
    'usSlash': DateFormat('MM/dd/yyyy HH:mm:ss'),
    'usSlash2': DateFormat('MM/dd/yyyy HH:mm'),
    'usSlash3': DateFormat('MM/dd/yyyy'),
    'usSlash4': DateFormat('MM/dd/yy HH:mm:ss'),
    'usSlash5': DateFormat('MM/dd/yy HH:mm'),
    'usSlash6': DateFormat('MM/dd/yy'),

    // Dash formats (International & US, 4 & 2 digit years)
    'dash': DateFormat('yyyy-MM-dd HH:mm:ss'),
    'dash2': DateFormat('yyyy-MM-dd HH:mm'),
    'dash3': DateFormat('yyyy-MM-dd'),
    'dash4': DateFormat('dd-MM-yyyy HH:mm:ss'),
    'dash5': DateFormat('dd-MM-yyyy HH:mm'),
    'dash6': DateFormat('dd-MM-yyyy'),
    'dash7': DateFormat('dd-MM-yy HH:mm:ss'),
    'dash8': DateFormat('dd-MM-yy HH:mm'),
    'dash9': DateFormat('dd-MM-yy'),
    'usDash': DateFormat('MM-dd-yyyy HH:mm:ss'),
    'usDash2': DateFormat('MM-dd-yyyy HH:mm'),
    'usDash3': DateFormat('MM-dd-yyyy'),
    'usDash4': DateFormat('MM-dd-yy HH:mm:ss'),
    'usDash5': DateFormat('MM-dd-yy HH:mm'),
    'usDash6': DateFormat('MM-dd-yy'),

    // Dot formats (International & US, 4 & 2 digit years)
    'dot': DateFormat('dd.MM.yyyy HH:mm'),
    'dot2': DateFormat('dd.MM.yyyy HH:mm:ss'),
    'dot3': DateFormat('dd.MM.yyyy'),
    'dot4': DateFormat('yyyy.MM.dd HH:mm:ss'),
    'dot5': DateFormat('yyyy.MM.dd HH:mm'),
    'dot6': DateFormat('yyyy.MM.dd'),
    'dot7': DateFormat('MM.dd.yyyy HH:mm:ss'),
    'dot8': DateFormat('MM.dd.yyyy HH:mm'),
    'dot9': DateFormat('MM.dd.yyyy'),
    'dot10': DateFormat('dd.MM.yy HH:mm:ss'),
    'dot11': DateFormat('dd.MM.yy HH:mm'),
    'dot12': DateFormat('dd.MM.yy'),
    'dot13': DateFormat('MM.dd.yy HH:mm:ss'),
    'dot14': DateFormat('MM.dd.yy HH:mm'),
    'dot15': DateFormat('MM.dd.yy'),

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

  // Pre-grouped lists of DateFormat to avoid filtering maps on the fly
  static final List<DateFormat> _compactFormats = [
    _formatMap['compact']!,
    _formatMap['compact2']!,
    _formatMap['compact3']!,
  ];

  static final List<DateFormat> _rfcFormats = [
    _formatMap['rfc']!,
    _formatMap['rfc2']!,
  ];

  static final List<DateFormat> _slashFormatsYyyyFirst = [
    _formatMap['slash4']!,
    _formatMap['slash5']!,
    _formatMap['slash6']!,
    _formatMap['slash']!,
    _formatMap['slash2']!,
    _formatMap['slash3']!,
    _formatMap['slash7']!,
    _formatMap['slash8']!,
    _formatMap['slash9']!,
    _formatMap['usSlash']!,
    _formatMap['usSlash2']!,
    _formatMap['usSlash3']!,
    _formatMap['usSlash4']!,
    _formatMap['usSlash5']!,
    _formatMap['usSlash6']!,
  ];

  static final List<DateFormat> _slashFormatsDdFirst = [
    _formatMap['slash']!,
    _formatMap['slash2']!,
    _formatMap['slash3']!,
    _formatMap['usSlash']!,
    _formatMap['usSlash2']!,
    _formatMap['usSlash3']!,
    _formatMap['slash7']!,
    _formatMap['slash8']!,
    _formatMap['slash9']!,
    _formatMap['usSlash4']!,
    _formatMap['usSlash5']!,
    _formatMap['usSlash6']!,
    _formatMap['slash4']!,
    _formatMap['slash5']!,
    _formatMap['slash6']!,
  ];

  static final List<DateFormat> _dashFormatsYyyyFirst = [
    _formatMap['dash']!,
    _formatMap['dash2']!,
    _formatMap['dash3']!,
    _formatMap['dash4']!,
    _formatMap['dash5']!,
    _formatMap['dash6']!,
    _formatMap['dash7']!,
    _formatMap['dash8']!,
    _formatMap['dash9']!,
    _formatMap['usDash']!,
    _formatMap['usDash2']!,
    _formatMap['usDash3']!,
    _formatMap['usDash4']!,
    _formatMap['usDash5']!,
    _formatMap['usDash6']!,
  ];

  static final List<DateFormat> _dashFormatsDdFirst = [
    _formatMap['dash4']!,
    _formatMap['dash5']!,
    _formatMap['dash6']!,
    _formatMap['usDash']!,
    _formatMap['usDash2']!,
    _formatMap['usDash3']!,
    _formatMap['dash7']!,
    _formatMap['dash8']!,
    _formatMap['dash9']!,
    _formatMap['usDash4']!,
    _formatMap['usDash5']!,
    _formatMap['usDash6']!,
    _formatMap['dash']!,
    _formatMap['dash2']!,
    _formatMap['dash3']!,
  ];

  static final List<DateFormat> _dotFormatsYyyyFirst = [
    _formatMap['dot4']!,
    _formatMap['dot5']!,
    _formatMap['dot6']!,
    _formatMap['dot']!,
    _formatMap['dot2']!,
    _formatMap['dot3']!,
    _formatMap['dot7']!,
    _formatMap['dot8']!,
    _formatMap['dot9']!,
    _formatMap['dot10']!,
    _formatMap['dot11']!,
    _formatMap['dot12']!,
    _formatMap['dot13']!,
    _formatMap['dot14']!,
    _formatMap['dot15']!,
  ];

  static final List<DateFormat> _dotFormatsDdFirst = [
    _formatMap['dot']!,
    _formatMap['dot2']!,
    _formatMap['dot3']!,
    _formatMap['dot7']!,
    _formatMap['dot8']!,
    _formatMap['dot9']!,
    _formatMap['dot10']!,
    _formatMap['dot11']!,
    _formatMap['dot12']!,
    _formatMap['dot13']!,
    _formatMap['dot14']!,
    _formatMap['dot15']!,
    _formatMap['dot4']!,
    _formatMap['dot5']!,
    _formatMap['dot6']!,
  ];

  static final List<DateFormat> _textFormats = [
    _formatMap['text']!,
    _formatMap['text2']!,
    _formatMap['text3']!,
    _formatMap['text4']!,
    _formatMap['text5']!,
    _formatMap['text6']!,
  ];

  static final List<DateFormat> _allFormats = _formatMap.values.toList();

  // Cached default output format
  static final DateFormat _defaultOutputFormat = DateFormat('dd/MM/yyyy HH:mm');

  // Precompiled Regular Expressions to avoid re-compilation on every method call
  static final RegExp _timezoneRegex = RegExp(r'([+-])(\d{2}):(\d{2})$');
  static final RegExp _digitsOnlyRegex = RegExp(r'^\d+$');
  static final RegExp _rfcStartRegex = RegExp(r'^[A-Za-z]+,');
  static final RegExp _alphaRegex = RegExp(r'[A-Za-z]');
  static final RegExp _wordBoundaryRegex = RegExp(r'\b[A-Za-z]{3}\b');
  static final RegExp _fourDigitYearStartRegex = RegExp(r'^\d{4}\b');

  // Case normalization map for RFC date string day and month abbreviations
  static const Map<String, String> _capitalizedNames = {
    'mon': 'Mon',
    'tue': 'Tue',
    'wed': 'Wed',
    'thu': 'Thu',
    'fri': 'Fri',
    'sat': 'Sat',
    'sun': 'Sun',
    'jan': 'Jan',
    'feb': 'Feb',
    'mar': 'Mar',
    'apr': 'Apr',
    'may': 'May',
    'jun': 'Jun',
    'jul': 'Jul',
    'aug': 'Aug',
    'sep': 'Sep',
    'oct': 'Oct',
    'nov': 'Nov',
    'dec': 'Dec',
  };

  /// Fix timezone formats like +05:30 → +0530 (remove colon for Z pattern)
  String _normalizeRfcTimezone(String input) {
    final match = _timezoneRegex.firstMatch(input);
    if (match != null) {
      final sign = match.group(1);
      final h = match.group(2);
      final m = match.group(3);
      return input.replaceAll(match.group(0)!, '$sign$h$m');
    }
    return input;
  }

  /// Normalize RFC date string for case-insensitive parsing in a single pass O(1) map lookup
  String _normalizeRfcCase(String input) {
    return input.replaceAllMapped(_wordBoundaryRegex, (match) {
      final word = match.group(0)!.toLowerCase();
      return _capitalizedNames[word] ?? match.group(0)!;
    });
  }

  /// Detect formats efficiently with precompiled RegExp and static lists
  List<DateFormat> _detectFormats(String s, {required bool isRfc}) {
    if (isRfc) {
      return _rfcFormats;
    }

    if (_digitsOnlyRegex.hasMatch(s)) {
      return _compactFormats;
    }

    final isYyyyFirst = _fourDigitYearStartRegex.hasMatch(s);

    if (s.contains('/')) {
      return isYyyyFirst ? _slashFormatsYyyyFirst : _slashFormatsDdFirst;
    }

    if (s.contains('-') && !_alphaRegex.hasMatch(s) && !s.contains(',')) {
      return isYyyyFirst ? _dashFormatsYyyyFirst : _dashFormatsDdFirst;
    }

    if (s.contains('.')) {
      return isYyyyFirst ? _dotFormatsYyyyFirst : _dotFormatsDdFirst;
    }

    if (_alphaRegex.hasMatch(s)) {
      return _textFormats;
    }

    return _allFormats;
  }

  /// Core parser that returns the DateTime object
  DateTime? _parseToDateTime(String input) {
    if (input.isEmpty) return null;

    // Pre-process compact/numeric strings by adding standard delimiters
    if (_digitsOnlyRegex.hasMatch(input)) {
      if (input.length == 8) {
        input =
            '${input.substring(0, 4)}-${input.substring(4, 6)}-${input.substring(6, 8)}';
      } else if (input.length == 12) {
        input =
            '${input.substring(0, 4)}-${input.substring(4, 6)}-${input.substring(6, 8)} ${input.substring(8, 10)}:${input.substring(10, 12)}';
      } else if (input.length == 14) {
        input =
            '${input.substring(0, 4)}-${input.substring(4, 6)}-${input.substring(6, 8)} ${input.substring(8, 10)}:${input.substring(10, 12)}:${input.substring(12, 14)}';
      }
    }

    // ISO first
    final iso = DateTime.tryParse(input);
    if (iso != null) return iso;

    // Check if this is an RFC format
    final isRfc = _rfcStartRegex.hasMatch(input);

    // Normalize RFC before detection & parsing
    if (isRfc) {
      input = _normalizeRfcCase(input);
      input = _normalizeRfcTimezone(input);
    }

    final isDigitsOnly = _digitsOnlyRegex.hasMatch(input);
    final candidates = _detectFormats(input, isRfc: isRfc);

    for (final fmt in candidates) {
      try {
        var parsed = (isRfc || isDigitsOnly)
            ? fmt.parse(input)
            : fmt.parseStrict(input);
        if (parsed.year < 100) {
          final fullYear = parsed.year >= 80
              ? 1900 + parsed.year
              : 2000 + parsed.year;
          parsed = DateTime(
            fullYear,
            parsed.month,
            parsed.day,
            parsed.hour,
            parsed.minute,
            parsed.second,
            parsed.millisecond,
            parsed.microsecond,
          );
        }
        return parsed;
      } catch (_) {}
    }

    // fallback using list iteration rather than map entry allocation
    for (final fmt in _allFormats) {
      try {
        var parsed = (isRfc || isDigitsOnly)
            ? fmt.parse(input)
            : fmt.parseStrict(input);
        if (parsed.year < 100) {
          final fullYear = parsed.year >= 80
              ? 1900 + parsed.year
              : 2000 + parsed.year;
          parsed = DateTime(
            fullYear,
            parsed.month,
            parsed.day,
            parsed.hour,
            parsed.minute,
            parsed.second,
            parsed.millisecond,
            parsed.microsecond,
          );
        }
        return parsed;
      } catch (_) {}
    }

    return null;
  }

  /// Core parser
  String _tryParseAndFormatDate(String input, String outputFormat) {
    // Avoid creating a new DateFormat instance on every call for the default format
    final outFmt = (outputFormat == 'dd/MM/yyyy HH:mm')
        ? _defaultOutputFormat
        : DateFormat(outputFormat);

    final parsed = _parseToDateTime(input);
    if (parsed != null) {
      return outFmt.format(parsed);
    }

    return 'Invalid date';
  }

  /// Parses the input [date] string automatically and formats it into the desired [outputDateFormat].
  ///
  /// The parser auto-detects slash, dash, dot, compact, text, RFC, and ISO formats, then
  /// reformats it to the target format.
  ///
  /// Returns `'Invalid date'` if the parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final parser = UniversalDateParser();
  /// String formatted = parser.formatDate(
  ///   date: '2025-11-21T14:20:00Z',
  ///   outputDateFormat: 'dd/MM/yyyy HH:mm',
  /// );
  /// print(formatted); // '21/11/2025 14:20'
  /// ```
  String formatDate({
    required String date,
    String outputDateFormat = 'dd/MM/yyyy HH:mm',
  }) {
    return _tryParseAndFormatDate(date, outputDateFormat);
  }

  /// Parses the input date string and returns a native [DateTime] object.
  ///
  /// Auto-detects 50+ format variations (ISO, slash, dash, dot, compact, named text, and RFC).
  /// Returns `null` if the parsing fails.
  ///
  /// Example:
  /// ```dart
  /// DateTime? parsed = UniversalDateParser.tryParse('21/11/2025 14:20');
  /// if (parsed != null) {
  ///   print(parsed.year); // 2025
  /// }
  /// ```
  static DateTime? tryParse(String date) {
    return _instance._parseToDateTime(date);
  }

  /// Parses the input date string and returns a native [DateTime] object.
  ///
  /// Auto-detects 50+ format variations.
  /// Throws a standard [FormatException] if the parsing fails.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   DateTime parsed = UniversalDateParser.parse('2025.11.21');
  ///   print(parsed.day); // 21
  /// } on FormatException catch (e) {
  ///   print('Failed: $e');
  /// }
  /// ```
  static DateTime parse(String date) {
    final parsed = _instance._parseToDateTime(date);
    if (parsed == null) {
      throw FormatException('Could not parse the date: $date');
    }
    return parsed;
  }

  /// Parses the input [date] string automatically and formats it into the desired [outputDateFormat]
  /// without requiring class instantiation.
  ///
  /// Returns `'Invalid date'` if the parsing fails.
  ///
  /// Example:
  /// ```dart
  /// String formatted = UniversalDateParser.format(
  ///   'Mon, 21 Nov 2025 14:20:00 +0530',
  ///   outputDateFormat: 'yyyy-MM-dd',
  /// );
  /// print(formatted); // '2025-11-21'
  /// ```
  static String format(
    String date, {
    String outputDateFormat = 'dd/MM/yyyy HH:mm',
  }) {
    return _instance._tryParseAndFormatDate(date, outputDateFormat);
  }

  static final UniversalDateParser _instance = UniversalDateParser();
}
