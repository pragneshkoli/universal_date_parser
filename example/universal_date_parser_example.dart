import 'package:universal_date_parser/universal_date_parser.dart';

void main() {
  final parser = UniversalDateParser();

  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('  Universal Date Parser - Supported Formats Demo');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  // ISO Formats
  print('📅 ISO 8601 Formats');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '2025-11-21T14:20:00.000Z', 'ISO with timezone Z');
  _printExample(parser, '2025-11-21T14:20:00+05:30', 'ISO with offset');
  _printExample(parser, '2025-11-21T14:20:00', 'ISO without timezone');
  print('');

  // Slash Formats
  print('📅 Slash (/) Formats');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '21/11/2025 14:20:30', 'dd/MM/yyyy HH:mm:ss');
  _printExample(parser, '21/11/2025 14:20', 'dd/MM/yyyy HH:mm');
  _printExample(parser, '21/11/2025', 'dd/MM/yyyy');
  _printExample(parser, '2025/11/21 14:20:30', 'yyyy/MM/dd HH:mm:ss');
  _printExample(parser, '2025/11/21 14:20', 'yyyy/MM/dd HH:mm');
  _printExample(parser, '2025/11/21', 'yyyy/MM/dd');
  print('');

  // Dash Formats
  print('📅 Dash (-) Formats');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '2025-11-21 14:20:30', 'yyyy-MM-dd HH:mm:ss');
  _printExample(parser, '2025-11-21 14:20', 'yyyy-MM-dd HH:mm');
  _printExample(parser, '2025-11-21', 'yyyy-MM-dd');
  _printExample(parser, '21-11-2025 14:20:30', 'dd-MM-yyyy HH:mm:ss');
  _printExample(parser, '21-11-2025 14:20', 'dd-MM-yyyy HH:mm');
  _printExample(parser, '21-11-2025', 'dd-MM-yyyy');
  print('');

  // Text Formats
  print('📅 Text/Named Month Formats');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '21 Nov 2025', 'dd MMM yyyy');
  _printExample(parser, '21 Nov 2025 14:20', 'dd MMM yyyy HH:mm');
  _printExample(parser, '21 Nov 2025 14:20:30', 'dd MMM yyyy HH:mm:ss');
  _printExample(parser, 'Nov 21, 2025', 'MMM dd, yyyy');
  _printExample(parser, 'Nov 21, 2025 14:20', 'MMM dd, yyyy HH:mm');
  _printExample(parser, 'Nov 21, 2025 14:20:30', 'MMM dd, yyyy HH:mm:ss');
  print('');

  // Compact Formats
  print('📅 Compact/Numeric Formats');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '20251121', 'yyyyMMdd');
  print('  ℹ️  Note: Longer compact formats (yyyyMMddHHmm, yyyyMMddHHmmss)');
  print('     are not reliably auto-detected to avoid false positives.');
  print('');

  // RFC Formats
  print('📅 RFC 2822 Formats (Case-Insensitive)');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, 'Mon, 21 Nov 2025 14:20:00 +05:30', 'Proper case');
  _printExample(parser, 'mon, 21 nov 2025 14:20:00 +05:30', 'Lowercase');
  _printExample(parser, 'MON, 21 NOV 2025 14:20:00 +05:30', 'Uppercase');
  _printExample(parser, 'Mon, 21 Nov 2025 14:20:00 +0530', 'Timezone +0530');
  _printExample(parser, 'Mon, 21 Nov 2025 14:20:00', 'Without timezone');
  print('');

  // Custom Output Formats
  print('📅 Custom Output Format Examples');
  print('─────────────────────────────────────────────────────');
  final input = '2025-11-21 14:20:30';
  print('Input: $input');
  print(
    '  → yyyy-MM-dd: ${parser.formatDate(date: input, outputDateFormat: "yyyy-MM-dd")}',
  );
  print(
    '  → dd/MM/yyyy: ${parser.formatDate(date: input, outputDateFormat: "dd/MM/yyyy")}',
  );
  print(
    '  → MMM dd, yyyy: ${parser.formatDate(date: input, outputDateFormat: "MMM dd, yyyy")}',
  );
  print(
    '  → dd MMM yyyy HH:mm:ss: ${parser.formatDate(date: input, outputDateFormat: "dd MMM yyyy HH:mm:ss")}',
  );
  print(
    '  → EEE, MMM dd yyyy: ${parser.formatDate(date: input, outputDateFormat: "EEE, MMM dd yyyy")}',
  );
  print('');

  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('  ✅ All formats parsed successfully!');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
}

void _printExample(
  UniversalDateParser parser,
  String input,
  String description,
) {
  final result = parser.formatDate(date: input);
  final status = result != 'Invalid date' ? '✓' : '✗';
  print('  $status $description');
  print('    Input:  $input');
  print('    Output: $result');
}
