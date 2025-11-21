import 'package:test/test.dart';
import 'package:universal_date_parser/universal_date_parser.dart';

void main() {
  final parser = UniversalDateParser();

  group('ISO date parsing', () {
    test('ISO with timezone Z', () {
      expect(
        parser.formatDate(
          date: "2025-11-21T14:20:00.000Z",
          outputDateFormat: "dd/MM/yyyy HH:mm",
        ),
        "21/11/2025 14:20",
      );
    });

    test('ISO with timezone offset', () {
      // Note: Timezone offsets convert to local time, so exact time may vary
      expect(
        parser.formatDate(
          date: "2025-11-21T14:20:00+05:30",
          outputDateFormat: "dd/MM/yyyy",
        ),
        "21/11/2025",
      );
    });

    test('ISO without timezone', () {
      expect(
        parser.formatDate(
          date: "2025-11-21T14:20:00",
          outputDateFormat: "dd/MM/yyyy HH:mm",
        ),
        "21/11/2025 14:20",
      );
    });
  });

  group('Slash format parsing', () {
    test('dd/MM/yyyy HH:mm:ss', () {
      expect(
        parser.formatDate(date: "21/11/2025 14:20:30"),
        "21/11/2025 14:20",
      );
    });

    test('dd/MM/yyyy HH:mm', () {
      expect(parser.formatDate(date: "21/11/2025 14:20"), "21/11/2025 14:20");
    });

    test('dd/MM/yyyy', () {
      expect(parser.formatDate(date: "21/11/2025"), "21/11/2025 00:00");
    });

    test('yyyy/MM/dd HH:mm:ss', () {
      expect(
        parser.formatDate(date: "2025/11/21 14:20:30"),
        "21/11/2025 14:20",
      );
    });

    test('yyyy/MM/dd HH:mm', () {
      expect(parser.formatDate(date: "2025/11/21 14:20"), "21/11/2025 14:20");
    });

    test('yyyy/MM/dd', () {
      expect(parser.formatDate(date: "2025/11/21"), "21/11/2025 00:00");
    });
  });

  group('Dash format parsing', () {
    test('yyyy-MM-dd HH:mm:ss', () {
      expect(
        parser.formatDate(date: "2025-11-21 14:20:30"),
        "21/11/2025 14:20",
      );
    });

    test('yyyy-MM-dd HH:mm', () {
      expect(parser.formatDate(date: "2025-11-21 14:20"), "21/11/2025 14:20");
    });

    test('yyyy-MM-dd', () {
      expect(parser.formatDate(date: "2025-11-21"), "21/11/2025 00:00");
    });

    test('dd-MM-yyyy HH:mm:ss', () {
      expect(
        parser.formatDate(date: "21-11-2025 14:20:30"),
        "21/11/2025 14:20",
      );
    });

    test('dd-MM-yyyy HH:mm', () {
      expect(parser.formatDate(date: "21-11-2025 14:20"), "21/11/2025 14:20");
    });

    test('dd-MM-yyyy', () {
      expect(parser.formatDate(date: "21-11-2025"), "21/11/2025 00:00");
    });
  });

  group('Text format parsing', () {
    test('dd MMM yyyy', () {
      expect(parser.formatDate(date: "21 Nov 2025"), "21/11/2025 00:00");
    });

    test('dd MMM yyyy HH:mm', () {
      expect(parser.formatDate(date: "21 Nov 2025 14:20"), "21/11/2025 14:20");
    });

    test('dd MMM yyyy HH:mm:ss', () {
      expect(
        parser.formatDate(date: "21 Nov 2025 14:20:30"),
        "21/11/2025 14:20",
      );
    });

    test('MMM dd, yyyy', () {
      expect(parser.formatDate(date: "Nov 21, 2025"), "21/11/2025 00:00");
    });

    test('MMM dd, yyyy HH:mm', () {
      expect(parser.formatDate(date: "Nov 21, 2025 14:20"), "21/11/2025 14:20");
    });

    test('MMM dd, yyyy HH:mm:ss', () {
      expect(
        parser.formatDate(date: "Nov 21, 2025 14:20:30"),
        "21/11/2025 14:20",
      );
    });
  });

  group('Compact format parsing', () {
    test('yyyyMMdd', () {
      expect(parser.formatDate(date: "20251121"), "21/11/2025 00:00");
    });

    // Note: Compact formats with time (yyyyMMddHHmm, yyyyMMddHHmmss)
    // are difficult to detect reliably with the current regex-based approach
    // as they could be confused with other numeric strings.
    // Consider using them with explicit format specification if needed.
  });

  group('RFC date parsing', () {
    test('RFC with proper case and timezone', () {
      expect(
        parser.formatDate(date: "Mon, 21 Nov 2025 14:20:00 +05:30"),
        "21/11/2025 14:20",
      );
    });

    test('RFC with lowercase day and month', () {
      expect(
        parser.formatDate(date: "mon, 21 nov 2025 14:20:00 +05:30"),
        "21/11/2025 14:20",
      );
    });

    test('RFC with uppercase day and month', () {
      expect(
        parser.formatDate(date: "MON, 21 NOV 2025 14:20:00 +05:30"),
        "21/11/2025 14:20",
      );
    });

    test('RFC with mixed case', () {
      expect(
        parser.formatDate(date: "MoN, 21 nOv 2025 14:20:00 +05:30"),
        "21/11/2025 14:20",
      );
    });

    test('RFC with timezone format +0530 (no colon)', () {
      expect(
        parser.formatDate(date: "Mon, 21 Nov 2025 14:20:00 +0530"),
        "21/11/2025 14:20",
      );
    });

    test('RFC without timezone', () {
      expect(
        parser.formatDate(date: "Mon, 21 Nov 2025 14:20:00"),
        "21/11/2025 14:20",
      );
    });

    test('RFC with different timezone', () {
      expect(
        parser.formatDate(date: "Fri, 25 Dec 2025 23:59:59 -08:00"),
        contains("25/12/2025"),
      );
    });
  });

  group('Custom output format', () {
    test('Output as yyyy-MM-dd', () {
      expect(
        parser.formatDate(
          date: "21/11/2025 14:20",
          outputDateFormat: "yyyy-MM-dd",
        ),
        "2025-11-21",
      );
    });

    test('Output as MMM dd, yyyy', () {
      expect(
        parser.formatDate(date: "2025-11-21", outputDateFormat: "MMM dd, yyyy"),
        "Nov 21, 2025",
      );
    });

    test('Output with full time', () {
      expect(
        parser.formatDate(
          date: "21/11/2025 14:20:30",
          outputDateFormat: "dd/MM/yyyy HH:mm:ss",
        ),
        "21/11/2025 14:20:30",
      );
    });
  });

  group('Invalid date handling', () {
    test('Invalid date string', () {
      expect(parser.formatDate(date: "not a date"), "Invalid date");
    });

    test('Empty string', () {
      expect(parser.formatDate(date: ""), "Invalid date");
    });

    test('Malformed date', () {
      expect(parser.formatDate(date: "32/13/2025"), "Invalid date");
    });
  });
}
