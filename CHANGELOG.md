## 1.1.0

- Added support for European dot-separated dates (`dd.MM.yyyy`, `yyyy.MM.dd`, `MM.dd.yyyy`, and 2-digit year variants).
- Added support for US slash/dash formats (`MM/dd/yyyy`, `MM-dd-yyyy`, and 2-digit year variants).
- Added support for 2-digit years with automatic pivoting conventions (<80 maps to 20xx, >=80 maps to 19xx).
- Added pre-processing normalization for compact numeric sequences (8, 12, or 14 digits) to bypass intl parser limitations.
- Added stateless static formatter interface `UniversalDateParser.format()`.
- Major performance optimizations: precompiled static RegExp objects, O(1) case capitalization map lookups, pre-allocated format lists, and cached default formats.
- Expanded unit testing suite from 35 to 75+ tests covering calendrical validation limits, timezone local-shifting, and edge cases.
- Updated Dart SDK constraint baseline to require ^3.12.0+.

## 1.0.1


- Updated repository and issue tracker URLs to correct GitHub repository

## 1.0.0

- Initial version.
