// helper_functions.dart

/// Calculates the age from the given birth date string.
///
/// The [birthDate] should be provided in the format "day/month/year" (e.g., "01/01/2000").
/// Returns the calculated age as a string.
String calculateAge(String birthDate) {
  // Split the birth date string into day, month, and year.
  List<String> parts = birthDate.split('/');

  // Parse day, month, and year from the string.
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);

  // Create a DateTime object for the date of birth.
  DateTime dob = DateTime(year, month, day);

  // Get the current date.
  final DateTime today = DateTime.now();

  // Calculate initial age based on the year difference.
  int calculatedAge = today.year - dob.year;

  // If today's date is before the birthday of this year, subtract one from the age.
  if (today.month < dob.month ||
      (today.month == dob.month && today.day < dob.day)) {
    calculatedAge--;
  }

  // Return the calculated age as a string.
  return calculatedAge.toString();
}
