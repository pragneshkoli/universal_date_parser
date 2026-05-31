import 'package:test/test.dart';
import 'package:universal_date_parser/universal_date_parser.dart';

void main() {
  final parser = UniversalDateParser();

  group('Senior QA Test Suite - Happy Paths & Formats', () {
    group('ISO-8601 Formats', () {
      test('ISO with UTC Z timezone', () {
        expect(
          parser.formatDate(
            date: '2025-11-21T14:20:00.000Z',
            outputDateFormat: 'dd/MM/yyyy HH:mm',
          ),
          '21/11/2025 14:20',
        );
      });

      test('ISO with positive offset (+05:30)', () {
        expect(
          parser.formatDate(
            date: '2025-11-21T14:20:00+05:30',
            outputDateFormat: 'dd/MM/yyyy',
          ),
          '21/11/2025',
        );
      });

      test('ISO with negative offset (-08:00)', () {
        expect(
          parser.formatDate(
            date: '2025-11-21T14:20:00-08:00',
            outputDateFormat: 'dd/MM/yyyy',
          ),
          '21/11/2025',
        );
      });

      test('ISO without timezone specifier', () {
        expect(
          parser.formatDate(
            date: '2025-11-21T14:20:00',
            outputDateFormat: 'dd/MM/yyyy HH:mm',
          ),
          '21/11/2025 14:20',
        );
      });

      test('ISO with millisecond fractions', () {
        expect(
          parser.formatDate(
            date: '2025-11-21T14:20:00.123Z',
            outputDateFormat: 'dd/MM/yyyy HH:mm',
          ),
          '21/11/2025 14:20',
        );
      });

      test('ISO with microsecond fractions', () {
        expect(
          parser.formatDate(
            date: '2025-11-21T14:20:00.123456Z',
            outputDateFormat: 'dd/MM/yyyy HH:mm',
          ),
          '21/11/2025 14:20',
        );
      });
    });

    group('Slash (/) Formats', () {
      test('dd/MM/yyyy HH:mm:ss', () {
        expect(
          parser.formatDate(date: '21/11/2025 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('dd/MM/yyyy HH:mm', () {
        expect(parser.formatDate(date: '21/11/2025 14:20'), '21/11/2025 14:20');
      });

      test('dd/MM/yyyy (date only)', () {
        expect(parser.formatDate(date: '21/11/2025'), '21/11/2025 00:00');
      });

      test('yyyy/MM/dd HH:mm:ss', () {
        expect(
          parser.formatDate(date: '2025/11/21 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('yyyy/MM/dd HH:mm', () {
        expect(parser.formatDate(date: '2025/11/21 14:20'), '21/11/2025 14:20');
      });

      test('yyyy/MM/dd (date only)', () {
        expect(parser.formatDate(date: '2025/11/21'), '21/11/2025 00:00');
      });

      test('dd/MM/yy HH:mm:ss (2-digit year)', () {
        expect(
          parser.formatDate(date: '21/11/25 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('dd/MM/yy HH:mm (2-digit year)', () {
        expect(parser.formatDate(date: '21/11/25 14:20'), '21/11/2025 14:20');
      });

      test('dd/MM/yy (2-digit year)', () {
        expect(parser.formatDate(date: '21/11/25'), '21/11/2025 00:00');
      });

      test('MM/dd/yyyy (US Format)', () {
        expect(parser.formatDate(date: '11/21/2025'), '21/11/2025 00:00');
      });

      test('MM/dd/yyyy HH:mm (US Format)', () {
        expect(parser.formatDate(date: '11/21/2025 14:20'), '21/11/2025 14:20');
      });

      test('MM/dd/yy (US 2-digit year)', () {
        expect(parser.formatDate(date: '11/21/25'), '21/11/2025 00:00');
      });

      test('Single-digit day/month handling', () {
        expect(parser.formatDate(date: '5/9/2025'), '05/09/2025 00:00');
      });
    });

    group('Dash (-) Formats', () {
      test('yyyy-MM-dd HH:mm:ss', () {
        expect(
          parser.formatDate(date: '2025-11-21 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('yyyy-MM-dd HH:mm', () {
        expect(parser.formatDate(date: '2025-11-21 14:20'), '21/11/2025 14:20');
      });

      test('yyyy-MM-dd (date only)', () {
        expect(parser.formatDate(date: '2025-11-21'), '21/11/2025 00:00');
      });

      test('dd-MM-yyyy HH:mm:ss', () {
        expect(
          parser.formatDate(date: '21-11-2025 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('dd-MM-yyyy HH:mm', () {
        expect(parser.formatDate(date: '21-11-2025 14:20'), '21/11/2025 14:20');
      });

      test('dd-MM-yyyy (date only)', () {
        expect(parser.formatDate(date: '21-11-2025'), '21/11/2025 00:00');
      });

      test('dd-MM-yy HH:mm:ss (2-digit year)', () {
        expect(
          parser.formatDate(date: '21-11-25 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('dd-MM-yy (2-digit year)', () {
        expect(parser.formatDate(date: '21-11-25'), '21/11/2025 00:00');
      });

      test('MM-dd-yyyy (US Format)', () {
        expect(parser.formatDate(date: '11-21-2025'), '21/11/2025 00:00');
      });

      test('MM-dd-yy (US 2-digit year)', () {
        expect(parser.formatDate(date: '11-21-25'), '21/11/2025 00:00');
      });
    });

    group('Dot (.) Formats', () {
      test('dd.MM.yyyy HH:mm:ss', () {
        expect(
          parser.formatDate(date: '21.11.2025 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('dd.MM.yyyy HH:mm', () {
        expect(parser.formatDate(date: '21.11.2025 14:20'), '21/11/2025 14:20');
      });

      test('dd.MM.yyyy (date only)', () {
        expect(parser.formatDate(date: '21.11.2025'), '21/11/2025 00:00');
      });

      test('yyyy.MM.dd', () {
        expect(parser.formatDate(date: '2025.11.21'), '21/11/2025 00:00');
      });

      test('MM.dd.yyyy (US Format)', () {
        expect(parser.formatDate(date: '11.21.2025'), '21/11/2025 00:00');
      });

      test('dd.MM.yy (2-digit year)', () {
        expect(parser.formatDate(date: '21.11.25'), '21/11/2025 00:00');
      });

      test('MM.dd.yy (US 2-digit year)', () {
        expect(parser.formatDate(date: '11.21.25'), '21/11/2025 00:00');
      });
    });

    group('Compact Formats', () {
      test('yyyyMMdd', () {
        expect(parser.formatDate(date: '20251121'), '21/11/2025 00:00');
      });

      test('yyyyMMddHHmm', () {
        // Test fallback parsing of long compact formats
        expect(parser.formatDate(date: '202511211420'), '21/11/2025 14:20');
      });

      test('yyyyMMddHHmmss', () {
        expect(parser.formatDate(date: '20251121142030'), '21/11/2025 14:20');
      });
    });

    group('Text / Named Month Formats', () {
      test('dd MMM yyyy', () {
        expect(parser.formatDate(date: '21 Nov 2025'), '21/11/2025 00:00');
      });

      test('dd MMM yyyy HH:mm', () {
        expect(
          parser.formatDate(date: '21 Nov 2025 14:20'),
          '21/11/2025 14:20',
        );
      });

      test('dd MMM yyyy HH:mm:ss', () {
        expect(
          parser.formatDate(date: '21 Nov 2025 14:20:30'),
          '21/11/2025 14:20',
        );
      });

      test('MMM dd, yyyy', () {
        expect(parser.formatDate(date: 'Nov 21, 2025'), '21/11/2025 00:00');
      });

      test('MMM dd, yyyy HH:mm', () {
        expect(
          parser.formatDate(date: 'Nov 21, 2025 14:20'),
          '21/11/2025 14:20',
        );
      });

      test('MMM dd, yyyy HH:mm:ss', () {
        expect(
          parser.formatDate(date: 'Nov 21, 2025 14:20:30'),
          '21/11/2025 14:20',
        );
      });
    });

    group('RFC-2822 / HTTP Headers', () {
      test('Standard RFC format', () {
        expect(
          parser.formatDate(date: 'Mon, 21 Nov 2025 14:20:00 +05:30'),
          '21/11/2025 14:20',
        );
      });

      test('RFC with lowercase abbreviations', () {
        expect(
          parser.formatDate(date: 'mon, 21 nov 2025 14:20:00 +05:30'),
          '21/11/2025 14:20',
        );
      });

      test('RFC with uppercase abbreviations', () {
        expect(
          parser.formatDate(date: 'MON, 21 NOV 2025 14:20:00 +05:30'),
          '21/11/2025 14:20',
        );
      });

      test('RFC with mixed case', () {
        expect(
          parser.formatDate(date: 'MoN, 21 nOv 2025 14:20:00 +05:30'),
          '21/11/2025 14:20',
        );
      });

      test('RFC with timezone offset lacking colon (+0530)', () {
        expect(
          parser.formatDate(date: 'Mon, 21 Nov 2025 14:20:00 +0530'),
          '21/11/2025 14:20',
        );
      });

      test('RFC without timezone offset', () {
        expect(
          parser.formatDate(date: 'Mon, 21 Nov 2025 14:20:00'),
          '21/11/2025 14:20',
        );
      });

      test('RFC with GMT time zone label', () {
        expect(
          parser.formatDate(date: 'Fri, 25 Dec 2025 23:59:59 GMT'),
          contains('25/12/2025'),
        );
      });
    });
  });

  group('Senior QA Test Suite - Calendrical Boundaries & Edge Cases', () {
    test('Leap year valid date (29 Feb 2024)', () {
      expect(parser.formatDate(date: '29/02/2024'), '29/02/2024 00:00');
    });

    test('Leap year invalid date (29 Feb 2025)', () {
      expect(parser.formatDate(date: '29/02/2025'), 'Invalid date');
    });

    test('End of year transitions (31 Dec 2025)', () {
      expect(
        parser.formatDate(date: '31/12/2025 23:59:59'),
        '31/12/2025 23:59',
      );
    });

    test('Start of year transitions (01 Jan 2026)', () {
      expect(
        parser.formatDate(date: '01/01/2026 00:00:00'),
        '01/01/2026 00:00',
      );
    });

    test(
      'Ambiguous date resolution prioritizes international (05/06/2025 → 5 June)',
      () {
        expect(parser.formatDate(date: '05/06/2025'), '05/06/2025 00:00');
      },
    );

    test('Unambiguous US date parses successfully (05/26/2025 → 26 May)', () {
      expect(parser.formatDate(date: '05/26/2025'), '26/05/2025 00:00');
    });

    test('Extreme time zone offset handling (+14:00)', () {
      expect(
        ['20/11/2025', '21/11/2025'],
        contains(
          parser.formatDate(
            date: '2025-11-21T14:20:00+14:00',
            outputDateFormat: 'dd/MM/yyyy',
          ),
        ),
      );
    });

    test('Extreme time zone offset handling (-12:00)', () {
      expect(
        ['21/11/2025', '22/11/2025'],
        contains(
          parser.formatDate(
            date: '2025-11-21T14:20:00-12:00',
            outputDateFormat: 'dd/MM/yyyy',
          ),
        ),
      );
    });
  });

  group('Senior QA Test Suite - Negative & Boundary Error Testing', () {
    test('Non-numeric garbage string', () {
      expect(parser.formatDate(date: 'not-a-valid-date'), 'Invalid date');
    });

    test('Empty string', () {
      expect(parser.formatDate(date: ''), 'Invalid date');
    });

    test('Whitespace only string', () {
      expect(parser.formatDate(date: '     '), 'Invalid date');
    });

    test('Partially complete date string', () {
      expect(parser.formatDate(date: '2025-11-'), 'Invalid date');
    });

    test('Month out of bounds (13)', () {
      expect(parser.formatDate(date: '21/13/2025'), 'Invalid date');
    });

    test('Day out of bounds (32)', () {
      expect(parser.formatDate(date: '32/11/2025'), 'Invalid date');
    });

    test('Logical date error (31 April - April only has 30 days)', () {
      expect(parser.formatDate(date: '31/04/2025'), 'Invalid date');
    });

    test('Logical date error (30 Feb)', () {
      expect(parser.formatDate(date: '30/02/2025'), 'Invalid date');
    });

    test('Hour out of bounds (24)', () {
      expect(parser.formatDate(date: '21/11/2025 24:00'), 'Invalid date');
    });

    test('Minute out of bounds (60)', () {
      expect(parser.formatDate(date: '21/11/2025 14:60'), 'Invalid date');
    });

    test('Special characters injected', () {
      expect(parser.formatDate(date: '21/11/2025! 14:20'), 'Invalid date');
    });
  });

  group('Senior QA Test Suite - Custom Formatting & Helpers', () {
    test('Custom format pattern with full day and month name', () {
      expect(
        parser.formatDate(
          date: '21/11/2025 14:20',
          outputDateFormat: 'EEEE, MMMM d, yyyy',
        ),
        'Friday, November 21, 2025',
      );
    });

    test('Custom format pattern for year only', () {
      expect(
        parser.formatDate(date: '2025-11-21', outputDateFormat: 'yyyy'),
        '2025',
      );
    });

    test('Static helper method matches instance output', () {
      final instanceResult = parser.formatDate(date: '2025-11-21 14:20:30');
      final staticResult = UniversalDateParser.format('2025-11-21 14:20:30');
      expect(staticResult, instanceResult);
    });

    test('Static helper method supports custom formatting', () {
      expect(
        UniversalDateParser.format(
          '21.11.2025',
          outputDateFormat: 'yyyy-MM-dd',
        ),
        '2025-11-21',
      );
    });
  });
}
