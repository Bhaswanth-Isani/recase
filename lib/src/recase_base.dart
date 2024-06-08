/// An instance of text to be re-cased.
class Recase {
  /// An instance of text to be re-cased.
  Recase(String text) {
    _words = _groupIntoWords(text);
  }

  final RegExp _upperAlphaRegex = RegExp('[A-Z]');

  final _symbolSet = {' ', '.', '/', '_', r'\', '-'};

  late List<String> _words;

  List<String> _groupIntoWords(String text) {
    final sb = StringBuffer();
    final words = <String>[];
    final isAllCaps = text.toUpperCase() == text;

    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      final nextChar = i + 1 == text.length ? null : text[i + 1];

      if (_symbolSet.contains(char)) {
        continue;
      }

      sb.write(char);

      final isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolSet.contains(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  /// camelCase
  String get camelCase => _getCamelCase();

  /// CONSTANT_CASE
  String get constantCase => _getConstantCase();

  /// Sentence case
  String get sentenceCase => _getSentenceCase();

  /// snake_case
  String get snakeCase => _getSnakeCase();

  /// dot.case
  String get dotCase => _getSnakeCase(separator: '.');

  /// param-case
  String get paramCase => _getSnakeCase(separator: '-');

  /// path/case
  String get pathCase => _getSnakeCase(separator: '/');

  /// PascalCase
  String get pascalCase => _getPascalCase();

  /// Header-Case
  String get headerCase => _getPascalCase(separator: '-');

  /// Title Case
  String get titleCase => _getPascalCase(separator: ' ');

  String _getCamelCase({String separator = ''}) {
    final words = _words.map(_upperCaseFirstLetter).toList();
    if (_words.isNotEmpty) {
      words[0] = words[0].toLowerCase();
    }

    return words.join(separator);
  }

  String _getConstantCase({String separator = '_'}) {
    final words = _words.map((word) => word.toUpperCase()).toList();

    return words.join(separator);
  }

  String _getPascalCase({String separator = ''}) {
    final words = _words.map(_upperCaseFirstLetter).toList();

    return words.join(separator);
  }

  String _getSentenceCase({String separator = ' '}) {
    final words = _words.map((word) => word.toLowerCase()).toList();
    if (_words.isNotEmpty) {
      words[0] = _upperCaseFirstLetter(words[0]);
    }

    return words.join(separator);
  }

  String _getSnakeCase({String separator = '_'}) {
    final words = _words.map((word) => word.toLowerCase()).toList();

    return words.join(separator);
  }

  String _upperCaseFirstLetter(String word) {
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
  }
}

/// Extension on top of String class to convert a particular string case into other string cases.
extension StringRecase on String {
  /// camelCase
  String get camelCase => Recase(this).camelCase;

  /// CONSTANT_CASE
  String get constantCase => Recase(this).constantCase;

  /// Sentence case
  String get sentenceCase => Recase(this).sentenceCase;

  /// snake_case
  String get snakeCase => Recase(this).snakeCase;

  /// dot.case
  String get dotCase => Recase(this).dotCase;

  /// param-case
  String get paramCase => Recase(this).paramCase;

  /// path/case
  String get pathCase => Recase(this).pathCase;

  /// PascalCase
  String get pascalCase => Recase(this).pascalCase;

  /// Header-Case
  String get headerCase => Recase(this).headerCase;

  /// Title Case
  String get titleCase => Recase(this).titleCase;
}

extension StringUtils on String {
  bool isMultiline() {
    return contains('\n');
  }
}
