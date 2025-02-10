// Helper method to calculate age based on the provided date.
String calculateAge(String birthDate) {
  List<String> parts = birthDate.split('/');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  DateTime dob = DateTime(year, month, day);
  final DateTime today = DateTime.now();
  int calculatedAge = today.year - dob.year;
  if (today.month < dob.month ||
      (today.month == dob.month && today.day < dob.day)) {
    calculatedAge--;
  }
  return calculatedAge.toString();
}
