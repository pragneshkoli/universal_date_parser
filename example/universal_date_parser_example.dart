import 'package:universal_date_parser/universal_date_parser.dart';

void main() {
  final parser = UniversalDateParser();

  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('  Universal Date Parser - Robust Senior-QA Demo');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  // 1. ISO Formats
  print('📅 1. ISO 8601 Formats (Z, timezone offsets, fractional seconds)');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '2025-11-21T14:20:00.000Z', 'ISO with timezone Z');
  _printExample(parser, '2025-11-21T14:20:00+05:30', 'ISO with offset');
  _printExample(
    parser,
    '2025-11-21T14:20:00.123456',
    'ISO with fractional microseconds',
  );
  print('');

  // 2. Slash Formats
  print('📅 2. Slash (/) Formats (International, US, 2-digit years)');
  print('─────────────────────────────────────────────────────');
  _printExample(
    parser,
    '21/11/2025 14:20:30',
    'International (dd/MM/yyyy HH:mm:ss)',
  );
  _printExample(
    parser,
    '21/11/25 14:20',
    'International 2-digit year (dd/MM/yy HH:mm)',
  );
  _printExample(parser, '11/21/2025', 'US Format (MM/dd/yyyy)');
  _printExample(parser, '11/21/25 14:20', 'US 2-digit year (MM/dd/yy HH:mm)');
  _printExample(parser, '5/9/2025', 'Single-digit day/month (d/M/yyyy)');
  print('');

  // 3. Dash Formats
  print('📅 3. Dash (-) Formats (International, US, 2-digit years)');
  print('─────────────────────────────────────────────────────');
  _printExample(
    parser,
    '2025-11-21 14:20:30',
    'Standard dash (yyyy-MM-dd HH:mm:ss)',
  );
  _printExample(parser, '21-11-2025', 'International date only (dd-MM-yyyy)');
  _printExample(parser, '21-11-25 14:20', '2-digit year (dd-MM-yy HH:mm)');
  _printExample(parser, '11-21-2025', 'US dash format (MM-dd-yyyy)');
  print('');

  // 4. Dot Formats
  print('📅 4. Dot (.) Formats (European, US, 2-digit years)');
  print('─────────────────────────────────────────────────────');
  _printExample(
    parser,
    '21.11.2025 14:20:30',
    'European standard (dd.MM.yyyy HH:mm:ss)',
  );
  _printExample(parser, '21.11.25', 'European 2-digit (dd.MM.yy)');
  _printExample(parser, '11.21.2025 14:20', 'US dot style (MM.dd.yyyy HH:mm)');
  _printExample(parser, '2025.11.21', 'Alt dot style (yyyy.MM.dd)');
  print('');

  // 5. Text Formats
  print('📅 5. Text/Named Month Formats');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '21 Nov 2025', 'dd MMM yyyy');
  _printExample(parser, 'Nov 21, 2025 14:20', 'MMM dd, yyyy HH:mm');
  print('');

  // 6. Compact Formats
  print('📅 6. Compact/Numeric Formats');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '20251121', '8-digit date (yyyyMMdd)');
  _printExample(parser, '202511211420', '12-digit date/time (yyyyMMddHHmm)');
  print('');

  // 7. RFC Formats
  print('📅 7. RFC 2822 / HTTP Header Formats (Case-Insensitive)');
  print('─────────────────────────────────────────────────────');
  _printExample(
    parser,
    'mon, 21 nov 2025 14:20:00 +0530',
    'Lowercase with flat timezone',
  );
  _printExample(
    parser,
    'MON, 21 NOV 2025 14:20:00 +05:30',
    'Uppercase with colon timezone',
  );
  _printExample(
    parser,
    'Fri, 25 Dec 2025 23:59:59 GMT',
    'Standard GMT labeled',
  );
  print('');

  // 8. Custom Output Formats
  print('📅 8. Custom Output Formatting Examples');
  print('─────────────────────────────────────────────────────');
  final input = '21.11.2025 14:20';
  print('  Input: $input');
  print(
    '  → "yyyy-MM-dd": ${parser.formatDate(date: input, outputDateFormat: 'yyyy-MM-dd')}',
  );
  print(
    '  → "EEEE, MMMM d, yyyy": ${parser.formatDate(date: input, outputDateFormat: 'EEEE, MMMM d, yyyy')}',
  );
  print('');

  // 9. Static Helper Method Demo
  print('⚡ 9. Static Helper Method (Zero instantiation required)');
  print('─────────────────────────────────────────────────────');
  final staticOutput = UniversalDateParser.format(
    '11/21/25',
    outputDateFormat: 'yyyy-MM-dd',
  );
  print(
    '  Code:  UniversalDateParser.format(\'11/21/25\', outputDateFormat: \'yyyy-MM-dd\')',
  );
  print('  Yield: $staticOutput');
  print('');

  // 10. Robust Calendrical Validation & Logical Errors Demo
  print('🛡️ 10. Robust Logical Error Handling & Negative Testing');
  print('─────────────────────────────────────────────────────');
  _printExample(parser, '29/02/2024', 'Valid leap year (29 Feb 2024)');
  _printExample(parser, '29/02/2025', 'Invalid leap year (29 Feb 2025)');
  _printExample(
    parser,
    '31/04/2025',
    'Invalid month day (31 Apr - Apr has 30 days)',
  );
  _printExample(parser, '21/13/2025', 'Out-of-range month (month 13)');
  _printExample(parser, 'garbage string', 'Non-date arbitrary string');
  print('');

  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('  ✅ Universal Date Parser Showcase Complete!');
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
