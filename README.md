# Universal Date Parser

A flexible and intelligent Dart package that automatically detects and parses dates in multiple formats without requiring you to specify the input format. Perfect for handling user input, API responses, or any scenario where date formats vary.

[![pub package](https://img.shields.io/pub/v/universal_date_parser.svg)](https://pub.dev/packages/universal_date_parser)

## ✨ Features

- 🔍 **Automatic Format Detection** - No need to specify input format, the parser detects it automatically
- 📅 **30+ Date Format Variations** - Supports ISO 8601, RFC 2822, and common date formats
- 🌍 **Case-Insensitive RFC Parsing** - Handles RFC dates in any case (Mon/mon/MON)
- 🕐 **Timezone Support** - Parses dates with or without timezone information
- 🎨 **Custom Output Formats** - Format output dates however you need
- ✅ **Well-Tested** - 35+ passing tests covering all formats
- 🚀 **Zero Configuration** - Works out of the box

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  universal_date_parser: ^1.0.0
```

Then run:

```bash
dart pub get
```

## 🚀 Quick Start

```dart
import 'package:universal_date_parser/universal_date_parser.dart';

void main() {
  final parser = UniversalDateParser();
  
  // Parse various formats automatically
  print(parser.formatDate(date: "2025-11-21T14:20:00.000Z"));
  // Output: 21/11/2025 14:20
  
  print(parser.formatDate(date: "Mon, 21 Nov 2025 14:20:00 +05:30"));
  // Output: 21/11/2025 14:20
  
  print(parser.formatDate(date: "21/11/2025 14:20"));
  // Output: 21/11/2025 14:20
  
  // Custom output format
  print(parser.formatDate(
    date: "2025-11-21",
    outputDateFormat: "MMM dd, yyyy"
  ));
  // Output: Nov 21, 2025
}
```

## 📋 Supported Date Formats

### ISO 8601 Formats
```dart
✅ 2025-11-21T14:20:00.000Z        // ISO with timezone Z
✅ 2025-11-21T14:20:00+05:30       // ISO with timezone offset
✅ 2025-11-21T14:20:00             // ISO without timezone
```

### Slash (/) Formats
```dart
✅ 21/11/2025 14:20:30             // dd/MM/yyyy HH:mm:ss
✅ 21/11/2025 14:20                // dd/MM/yyyy HH:mm
✅ 21/11/2025                      // dd/MM/yyyy
✅ 2025/11/21 14:20:30             // yyyy/MM/dd HH:mm:ss
✅ 2025/11/21 14:20                // yyyy/MM/dd HH:mm
✅ 2025/11/21                      // yyyy/MM/dd
```

### Dash (-) Formats
```dart
✅ 2025-11-21 14:20:30             // yyyy-MM-dd HH:mm:ss
✅ 2025-11-21 14:20                // yyyy-MM-dd HH:mm
✅ 2025-11-21                      // yyyy-MM-dd
✅ 21-11-2025 14:20:30             // dd-MM-yyyy HH:mm:ss
✅ 21-11-2025 14:20                // dd-MM-yyyy HH:mm
✅ 21-11-2025                      // dd-MM-yyyy
```

### Text/Named Month Formats
```dart
✅ 21 Nov 2025                     // dd MMM yyyy
✅ 21 Nov 2025 14:20               // dd MMM yyyy HH:mm
✅ 21 Nov 2025 14:20:30            // dd MMM yyyy HH:mm:ss
✅ Nov 21, 2025                    // MMM dd, yyyy
✅ Nov 21, 2025 14:20              // MMM dd, yyyy HH:mm
✅ Nov 21, 2025 14:20:30           // MMM dd, yyyy HH:mm:ss
```

### RFC 2822 Formats (Case-Insensitive)
```dart
✅ Mon, 21 Nov 2025 14:20:00 +05:30    // Proper case with timezone
✅ mon, 21 nov 2025 14:20:00 +05:30    // Lowercase
✅ MON, 21 NOV 2025 14:20:00 +05:30    // Uppercase
✅ Mon, 21 Nov 2025 14:20:00 +0530     // Timezone without colon
✅ Mon, 21 Nov 2025 14:20:00           // Without timezone
```

### Compact Formats
```dart
✅ 20251121                        // yyyyMMdd
```

> **Note**: Longer compact formats (yyyyMMddHHmm, yyyyMMddHHmmss) are not automatically detected to avoid false positives with other numeric strings.

## 💡 Usage Examples

### Basic Usage

```dart
final parser = UniversalDateParser();

// Default output format: dd/MM/yyyy HH:mm
String result = parser.formatDate(date: "2025-11-21");
print(result); // 21/11/2025 00:00
```

### Custom Output Format

```dart
final parser = UniversalDateParser();

// Custom output format
String result = parser.formatDate(
  date: "Mon, 21 Nov 2025 14:20:00 +05:30",
  outputDateFormat: "yyyy-MM-dd HH:mm:ss"
);
print(result); // 2025-11-21 14:20:00
```

### Multiple Format Examples

```dart
final parser = UniversalDateParser();

// All of these work automatically!
print(parser.formatDate(date: "2025-11-21T14:20:00Z"));
print(parser.formatDate(date: "21/11/2025 14:20"));
print(parser.formatDate(date: "21-11-2025 14:20"));
print(parser.formatDate(date: "21 Nov 2025 14:20"));
print(parser.formatDate(date: "Nov 21, 2025 14:20"));
print(parser.formatDate(date: "Mon, 21 Nov 2025 14:20:00 +05:30"));

// All output: 21/11/2025 14:20
```

### Error Handling

```dart
final parser = UniversalDateParser();

String result = parser.formatDate(date: "not a valid date");
print(result); // "Invalid date"

// Check for invalid dates
if (result == "Invalid date") {
  print("Failed to parse date");
}
```

## 🎨 Available Output Format Patterns

You can customize the output using any valid DateFormat pattern:

| Pattern | Description | Example |
|---------|-------------|---------|
| `yyyy` | 4-digit year | 2025 |
| `yy` | 2-digit year | 25 |
| `MM` | 2-digit month | 11 |
| `M` | Month without leading zero | 11 |
| `MMM` | Abbreviated month name | Nov |
| `MMMM` | Full month name | November |
| `dd` | 2-digit day | 21 |
| `d` | Day without leading zero | 21 |
| `HH` | 24-hour format hour | 14 |
| `hh` | 12-hour format hour | 02 |
| `mm` | Minutes | 20 |
| `ss` | Seconds | 30 |
| `EEE` | Abbreviated day name | Mon |
| `EEEE` | Full day name | Monday |

### Example Output Formats

```dart
final parser = UniversalDateParser();
final input = "2025-11-21 14:20:30";

parser.formatDate(date: input, outputDateFormat: "yyyy-MM-dd");
// Output: 2025-11-21

parser.formatDate(date: input, outputDateFormat: "dd/MM/yyyy");
// Output: 21/11/2025

parser.formatDate(date: input, outputDateFormat: "MMM dd, yyyy");
// Output: Nov 21, 2025

parser.formatDate(date: input, outputDateFormat: "EEEE, MMMM dd, yyyy");
// Output: Friday, November 21, 2025

parser.formatDate(date: input, outputDateFormat: "dd MMM yyyy HH:mm:ss");
// Output: 21 Nov 2025 14:20:30
```

## 🔍 How It Works

The parser uses intelligent format detection:

1. **ISO 8601 Detection**: Tries to parse as ISO format first using `DateTime.tryParse()`
2. **Pattern Recognition**: Analyzes the input string to detect likely format category
3. **Format Matching**: Attempts to parse using candidate formats from the detected category
4. **Fallback**: If all else fails, tries all available formats
5. **Normalization**: For RFC dates, normalizes case and timezone format before parsing

### Special Features

- **Case-Insensitive RFC Parsing**: Automatically normalizes day/month names (Mon/mon/MON all work)
- **Timezone Normalization**: Handles both `+05:30` and `+0530` timezone formats
- **Smart Detection**: Uses regex patterns to quickly identify format categories

## 📖 API Reference

### `UniversalDateParser`

#### `formatDate({required String date, String outputDateFormat = 'dd/MM/yyyy HH:mm'})`

Parses the input date string and returns it in the specified output format.

**Parameters:**
- `date` (String, required): The input date string to parse
- `outputDateFormat` (String, optional): The desired output format pattern. Default: `'dd/MM/yyyy HH:mm'`

**Returns:**
- `String`: The formatted date string, or `"Invalid date"` if parsing fails

**Example:**
```dart
final parser = UniversalDateParser();
String result = parser.formatDate(
  date: "2025-11-21",
  outputDateFormat: "MMM dd, yyyy"
);
```

## 🧪 Running Tests

The package includes comprehensive test coverage:

```bash
dart test
```

**Test Coverage:**
- ✅ 35 passing tests
- ✅ ISO 8601 formats
- ✅ Slash, dash, and text formats
- ✅ RFC 2822 formats (all case variations)
- ✅ Custom output formats
- ✅ Error handling

## 📝 Example Application

Run the included example to see all supported formats:

```bash
dart run example/universal_date_parser_example.dart
```

This will display a comprehensive demo of all 30+ supported date format variations.

## 🤝 Contributing

Contributions are welcome! If you find a bug or want to add a feature:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Built with Dart's `intl` package for robust date formatting
- Inspired by the need for flexible date parsing in real-world applications

## ⚠️ Known Limitations

- Compact formats with time (yyyyMMddHHmm, yyyyMMddHHmmss) are not auto-detected to prevent false positives
- Ambiguous formats (like MM/dd/yyyy vs dd/MM/yyyy) default to dd/MM/yyyy
- Timezone conversion depends on the system's local timezone settings

## 📞 Support

If you have any questions or issues, please file an issue on the GitHub repository.

---

Made with ❤️ for the Dart community
