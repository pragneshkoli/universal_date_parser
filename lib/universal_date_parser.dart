import 'src/universal_date_parser_base.dart';

export 'src/universal_date_parser_base.dart';

/// Top-level global function to parse a date string into a native [DateTime] object.
/// Returns `null` if parsing fails.
///
/// Example:
/// ```dart
/// final date = tryParseDate('21/11/2025');
/// ```
DateTime? tryParseDate(String date) => UniversalDateParser.tryParse(date);

/// Top-level global function to parse a date string into a native [DateTime] object.
/// Throws a [FormatException] if parsing fails.
///
/// Example:
/// ```dart
/// final date = parseDate('2025-11-21');
/// ```
DateTime parseDate(String date) => UniversalDateParser.parse(date);

/// Top-level global function to format a date string automatically.
/// Returns `'Invalid date'` if parsing fails.
///
/// Example:
/// ```dart
/// final string = formatDate('2025-11-21', outputDateFormat: 'dd/MM/yyyy');
/// ```
String formatDate(
  String date, {
  String outputDateFormat = 'dd/MM/yyyy HH:mm',
}) => UniversalDateParser.format(date, outputDateFormat: outputDateFormat);

/// Elegant String extension offering direct parsing and formatting methods
/// on any string, zero-instantiation required.
///
/// Example:
/// ```dart
/// String display = '21.11.25'.formatDate();
/// DateTime? parsed = '11/21/2025'.tryParseDate();
/// ```
extension UniversalDateParserExtension on String {
  /// Automatically parses this string and returns a formatted date string.
  /// Returns `'Invalid date'` if parsing fails.
  String formatDate({String outputDateFormat = 'dd/MM/yyyy HH:mm'}) {
    return UniversalDateParser.format(this, outputDateFormat: outputDateFormat);
  }

  /// Automatically parses this string and returns a native [DateTime] object.
  /// Returns `null` if parsing fails.
  DateTime? tryParseDate() {
    return UniversalDateParser.tryParse(this);
  }

  /// Automatically parses this string and returns a native [DateTime] object.
  /// Throws a [FormatException] if parsing fails.
  DateTime parseDate() {
    return UniversalDateParser.parse(this);
  }
}
