extension StringExtensions on String {
  bool get isBlank => trim().isEmpty;

  String get trimmed => trim();

  String ellipsize(int max) => length <= max ? this : '${substring(0, max)}…';
}
