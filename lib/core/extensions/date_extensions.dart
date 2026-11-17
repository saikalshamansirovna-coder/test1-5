extension DateExtensions on DateTime {
  String toFormattedDate() {
    String day = this.day.toString().padLeft(2, '0');
    String month = this.month.toString().padLeft(2, '0');
    String year = this.year.toString();

    return '$day.$month.$year';
  }
}
