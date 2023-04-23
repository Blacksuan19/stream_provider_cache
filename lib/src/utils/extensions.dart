extension StringExtenions on String {
  String get capitalize {
    if (trim().isEmpty) {
      return '';
    }
    return snakeCase
        .split('_')
        .map(
          (element) =>
              "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}",
        )
        .join(" ");
  }

  /// convert string to snake_case.
  ///
  /// e.g. "camelCase".snakeCase => "camel_case"
  String get snakeCase => replaceAllMapped(
        RegExp('([A-Z])'),
        (match) => "_${match[1]!.toLowerCase()}",
      );

  /// remove last n characters from a string.
  ///
  /// e.g. "ahmed".removeLast() => "ahme"
  /// e.g. "ahmed".removeLast(2) => "ahm"
  String removeLast({int n = 1}) => substring(0, length - n);
}

extension ToSnakeCase on Enum {
  /// convert enum to snake_case.
  ///
  /// e.g. RecordingsTypes.Letter.toSnakeCase => "letter"
  String get toSnakeCase => toString().split('.').last.snakeCase;
}
