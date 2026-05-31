# Universal Date Parser

A highly optimized, auto-detecting, bulletproof date parsing package for Dart and Flutter. Automatically resolves, parses, and reformats date strings without requiring you to manually specify the input pattern. Perfect for handling varying user inputs, erratic API responses, or inconsistent legacy databases.

[![pub package](https://img.shields.io/pub/v/universal_date_parser.svg)](https://pub.dev/packages/universal_date_parser)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

---

## ✨ Features

- 🔍 **Auto-Detect Format Routing**: Instant pattern matching handles date formats automatically.
- ⚡ **Static Utility Interface**: Call `UniversalDateParser.format()` directly to skip class instantiation.
- 🚀 **High-Performance Architecture**: Built for zero-overhead hot paths (precompiled regular expressions, pre-grouped list allocations, cached common output formatters, and O(1) case capitalization map lookups).
- 📅 **50+ Date Format Variations**: Full support for ISO-8601, RFC-2822, European Dot-separated dates, US (Month/Day/Year) layouts, 2-digit years, and compact strings.
- 🌍 **Case-Insensitive RFC/HTTP Header Parsing**: Easily handles HTTP/RFC date formats in any case casing (`Mon`, `mon`, `MON`).
- 🛡️ **Logical Calendrical Validation**: Rejects invalid dates automatically (e.g., April 31st, February 30th, month 13, non-leap year Feb 29ths).
- ✅ **Exhaustive Testing Suite**: 75+ passing unit tests covering edge cases, leap years, timezone offsets, and bounds.

---

## 📦 Installation

Add the dependency to your package's `pubspec.yaml` file:

```yaml
environment:
  sdk: ^3.12.0 # Supports Dart 3.12.0+ & Flutter 3.44.0+

dependencies:
  universal_date_parser: ^1.1.0
```

Then download the package:

```bash
dart pub get
```

---

## 🚀 Quick Start

### Instance-level Usage
```dart
import 'package:universal_date_parser/universal_date_parser.dart';

void main() {
  final parser = UniversalDateParser();
  
  // Parse various formats automatically
  print(parser.formatDate(date: '2025-11-21T14:20:00.000Z')); 
  // Output: 21/11/2025 14:20
  
  print(parser.formatDate(date: 'Mon, 21 Nov 2025 14:20:00 +05:30')); 
  // Output: 21/11/2025 14:20
  
  print(parser.formatDate(date: '21.11.25 14:20')); 
  // Output: 21/11/2025 14:20
}
```

### Static Utility Usage (Stateless)
You do not need to instantiate the class if you are writing quick parsing logic:
```dart
import 'package:universal_date_parser/universal_date_parser.dart';

void main() {
  // Uses the highly optimized static singleton parser
  final formatted = UniversalDateParser.format('11/21/25', outputDateFormat: 'yyyy-MM-dd');
  print(formatted); 
  // Output: 2025-11-21
}
```

---

## 📋 Supported Date Formats

The parser matches, detects, and falls back to a massive catalog of date variations:

### ISO 8601 Formats (Instant Fast-Path)
- `2025-11-21T14:20:00.000Z` (UTC Specifier)
- `2025-11-21T14:20:00+05:30` (Timezone Offset)
- `2025-11-21T14:20:00.123456` (Microsecond Accuracy)
- `2025-11-21` (Date only)

### Slash (/) Formats (European, US, 4 & 2 digit years)
- `dd/MM/yyyy HH:mm:ss` / `dd/MM/yyyy HH:mm` / `dd/MM/yyyy` (e.g., `21/11/2025`)
- `yyyy/MM/dd HH:mm:ss` / `yyyy/MM/dd HH:mm` / `yyyy/MM/dd` (e.g., `2025/11/21`)
- `dd/MM/yy HH:mm:ss` / `dd/MM/yy` (e.g., `21/11/25`)
- `MM/dd/yyyy HH:mm:ss` / `MM/dd/yyyy` (e.g., `11/21/2025` - US Format)
- `MM/dd/yy HH:mm:ss` / `MM/dd/yy` (e.g., `11/21/25` - US 2-digit format)

### Dash (-) Formats (European, US, 4 & 2 digit years)
- `yyyy-MM-dd HH:mm:ss` / `yyyy-MM-dd HH:mm` / `yyyy-MM-dd` (e.g., `2025-11-21`)
- `dd-MM-yyyy HH:mm:ss` / `dd-MM-yyyy HH:mm` / `dd-MM-yyyy` (e.g., `21-11-2025`)
- `dd-MM-yy HH:mm:ss` / `dd-MM-yy` (e.g., `21-11-25`)
- `MM-dd-yyyy HH:mm:ss` / `MM-dd-yyyy` (e.g., `11-21-2025` - US format)
- `MM-dd-yy` (e.g., `11-21-25` - US 2-digit format)

### Dot (.) Formats (European, US, 4 & 2 digit years)
- `dd.MM.yyyy HH:mm:ss` / `dd.MM.yyyy HH:mm` / `dd.MM.yyyy` (e.g., `21.11.2025`)
- `yyyy.MM.dd HH:mm:ss` / `yyyy.MM.dd` (e.g., `2025.11.21`)
- `MM.dd.yyyy HH:mm:ss` / `MM.dd.yyyy` (e.g., `11.21.2025` - US format)
- `dd.MM.yy` / `MM.dd.yy` (e.g., `21.11.25`, `11.21.25` - 2-digit variants)

### Text/Named Month Formats
- `dd MMM yyyy HH:mm:ss` / `dd MMM yyyy` (e.g., `21 Nov 2025`)
- `MMM dd, yyyy HH:mm:ss` / `MMM dd, yyyy` (e.g., `Nov 21, 2025`)

### Compact (Purely Numeric) Formats
- `yyyyMMdd` (e.g., `20251121`)
- `yyyyMMddHHmm` (e.g., `202511211420`)
- `yyyyMMddHHmmss` (e.g., `20251121142030`)

### RFC 2822 / HTTP Header Formats (Case-Insensitive)
- `Mon, 21 Nov 2025 14:20:00 +05:30` (Proper case)
- `mon, 21 nov 2025 14:20:00 +0530` (Lowercase, flat timezone)
- `MON, 21 NOV 2025 14:20:00` (Uppercase, no timezone)
- `Fri, 25 Dec 2025 23:59:59 GMT` (GMT Standard label)

---

## 🎨 Custom Formatting Outputs

Output formatted strings are highly customizable by specifying `outputDateFormat` during calls:

```dart
final input = '2025-11-21 14:20:30';

UniversalDateParser.format(input, outputDateFormat: 'yyyy-MM-dd');
// Output: 2025-11-21

UniversalDateParser.format(input, outputDateFormat: 'EEEE, MMMM d, yyyy');
// Output: Friday, November 21, 2025

UniversalDateParser.format(input, outputDateFormat: 'dd MMM yyyy HH:mm:ss');
// Output: 21 Nov 2025 14:20:30
```

---

The parser utilizes an intelligent routing engine to process dates through optimized fast-paths and fallback layers:

```
 [Input String] ────────► [Preprocess: Digits Only?] ──► Yes (8/12/14 chars) ──► [Insert separators: yyyy-MM-dd HH:mm:ss]
                               │                                                                  │
                               ▼ No ◄─────────────────────────────────────────────────────────────┘
                      [Try ISO 8601 parsing] ──► Succeeded ──► [Return Formatted Output]
                               │
                               ▼ Failed
                        [Is RFC Start?] ──► Yes ──► [Normalize Case & TZ Colon] ──► [Run Auto-Detection]
                               │                                                            ▲
                               └─────────── No ─────────────────────────────────────────────┘
                                                                                            │
                                                                                            ▼
                                                                                 [Try Category Candidates]
                                                                                            │
                                                                                  ┌─────────┴─────────┐
                                                                                  ▼                   ▼
                                                                              Succeeded             Failed
                                                                                  │                   │
                                                                                  ▼                   ▼
                                                                           [Return Output]     [Try Fallbacks]
                                                                                                      │
                                                                                            ┌─────────┴─────────┐
                                                                                            ▼                   ▼
                                                                                        Succeeded             Failed
                                                                                            │                   │
                                                                                            ▼                   ▼
                                                                                     [Return Output]    [Return "Invalid date"]
```


### Engineered for Maximum Performance:
1. **Direct Delimiter Insertion**: Purely numeric strings (length 8, 12, 14) are pre-segmented with standard dash delimiters, allowing them to instantly bypass complex pattern parsing and resolve directly via `DateTime.tryParse()`.
2. **Precompiled Regex Assets**: All Regular Expression objects are allocated once as `static final` members, removing heavy regex compile cycles during consecutive format runs.
3. **O(1) Capitalization Normalization**: Rather than looping and performing 19 sequential regex replacements for day/month casing in RFCs, a single-pass `\b[A-Za-z]{3}\b` replacement resolves casing immediately via map lookup.
4. **Grouped Memory References**: Candidate detection lists are pre-allocated statically. Auto-detection directly returns static array references instead of generating, filtering, and mapping lists on the fly.
5. **Direct Format Caching**: Pre-compiles the default output formatter `DateFormat('dd/MM/yyyy HH:mm')` as a static final object to prevent initialization overhead.

---

## ⚠️ Known Limitations & Ambiguity Resolutions

While `UniversalDateParser` is built to be extremely flexible, developers must be aware of certain logic constraints:

### 1. Resolution of Ambiguous Formats (European vs. US Dates)
When an ambiguous numeric date is passed (e.g., `05/06/2025`), it is mathematically impossible to differentiate between **June 5th** (European/International) and **May 6th** (US format) without context.
- **Resolution Behavior**: The parser **prioritizes International/European conventions (`dd/MM/yyyy`) by default** over US structures. Therefore, `05/06/2025` will always be resolved as **June 5th, 2025**.
- **US Fallback Resolution**: If a US date is unambiguous (e.g., `05/26/2025` where the month cannot be 26), the International parser will reject it, and the fallback pipeline will automatically attempt and successfully parse it using the US formatter as **May 26th, 2025**.

### 2. Timezone Shifting in ISO Formats
Dates containing timezone offsets (e.g. `2025-11-21T14:20:00-12:00` or `2025-11-21T14:20:00.000Z`) are parsed using Dart's native `DateTime.tryParse()`. 
- **Resolution Behavior**: Native Dart parsing converts these values into the **local timezone of the host device**. 
- **Developer Notice**: If your local timezone offset shifts the date across a midnight boundary (for example, parsing an offset of `-12:00` on a device set to `+05:30` local time), the resulting formatted date string will reflect the local date (e.g. transitioning from the 21st to the 22nd).

### 3. 2-Digit Year Pivoting
When parsing 2-digit years (such as `21/11/25` or `11-21-85`):
- **Resolution Behavior**: The parser implements a **fixed pivot window at year 80**:
  - Values **under 80** resolve to the 21st Century (`20xx`). E.g., `25` -> `2025`.
  - Values **80 and above** resolve to the 20th Century (`19xx`). E.g., `85` -> `1985`.

### 4. Non-Standard Compact Formats
Compact numeric sequences must be exactly 8, 12, or 14 characters long (`yyyyMMdd`, `yyyyMMddHHmm`, or `yyyyMMddHHmmss`). Numeric representations outside these lengths (e.g., a 10-digit number like `2025112114`) cannot be safely auto-delimited and will fall back to `"Invalid date"`.

---

## 🧪 Running Tests

The test suite covers happy paths, edge cases, boundaries, timezone offsets, leap years, static helper execution, and calendrical errors. To run the suite:

```bash
dart test
```

*Output:*
```bash
00:00 +75: All tests passed!
```

---

## 📝 Example Demo Showcase

To see the date parser resolve 30+ different formats in real time, execute the console example app:

```bash
dart run example/universal_date_parser_example.dart
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
