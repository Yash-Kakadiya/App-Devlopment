import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/app_colors.dart';
import '../../utils/helper_functions.dart';

/// A stateful widget for the birthdate onboarding page.
/// This page allows the user to select their date of birth using a date picker,
/// displays the formatted birthdate, and calculates the user's age.
class BirthdateOnboardingPage extends StatefulWidget {
  /// The name of the user (used in the prompt).
  final String name;

  /// Controller for the birthdate input field.
  final TextEditingController birthdateController;

  /// Controller for the age field (automatically updated based on the birthdate).
  final TextEditingController ageController;

  /// Global key for the form on this page.
  final GlobalKey<FormState> formKey;

  /// Creates a [BirthdateOnboardingPage] widget.
  const BirthdateOnboardingPage({
    super.key,
    required this.name,
    required this.birthdateController,
    required this.ageController,
    required this.formKey,
  });

  @override
  State<BirthdateOnboardingPage> createState() =>
      _BirthdateOnboardingPageState();
}

/// State class for [BirthdateOnboardingPage] that handles date selection and age calculation.
class _BirthdateOnboardingPageState extends State<BirthdateOnboardingPage> {
  /// The currently selected date.
  DateTime? selectedDate;

  @override
  void initState() {
    // If the age controller already has text, parse the birthdate string
    // to set the selected date.
    if (widget.ageController.text.isNotEmpty) {
      // Split the birthdate string into day, month, and year.
      List<String> parts = widget.birthdateController.text.split('/');
      // Parse day, month, and year from the string.
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      // Set the selectedDate based on the parsed values.
      selectedDate = DateTime(year, month, day);
    }
    super.initState();
  }

  /// Displays a bottom sheet date picker for the user to select their birthdate.
  /// The allowed date range is calculated based on the user's age requirements (18 to 80 years old).
  void showDatePicker() async {
    DateTime today = DateTime.now();
    // Calculate the latest allowed birthdate: user must be at least 18 years old.
    DateTime lastAllowedDate =
        DateTime(today.year - 18, today.month, today.day);
    // Calculate the earliest allowed birthdate: user must be no more than 80 years old.
    DateTime firstAllowedDate =
        DateTime(today.year - 80, today.month, today.day);

    // Show a modal bottom sheet with a CalendarDatePicker.
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // A small grab handle to indicate the sheet can be swiped.
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title of the date picker.
              const Text(
                'Birthday',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // The calendar picker widget.
              Expanded(
                child: CalendarDatePicker(
                  // Use the currently selected date or default to the last allowed date.
                  initialDate: selectedDate ?? lastAllowedDate,
                  firstDate: firstAllowedDate,
                  lastDate: lastAllowedDate,
                  onDateChanged: (DateTime date) {
                    // Update the selected date immediately.
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ),
              // Button to save the selected date.
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Close the bottom sheet and return the selected date.
                    Navigator.pop(context, selectedDate);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Save DOB 😀',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    // If the user picked a date, update the controllers and state.
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        // Format the picked date as 'dd/MM/yyyy' and update the birthdate controller.
        widget.birthdateController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
        // Calculate the age based on the selected birthdate and update the age controller.
        widget.ageController.text =
            calculateAge(widget.birthdateController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // Use the provided form key for validation.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display a title asking the user for their birthdate.
          Text(
            "${widget.name}, Your birthdate? 🎂",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          // Read-only text form field that shows the selected birthdate.
          // Tapping this field will open the date picker.
          TextFormField(
            readOnly: true,
            keyboardType: TextInputType.datetime,
            controller: widget.birthdateController,
            onTap: showDatePicker,
            validator: (value) {
              // Ensure the birthdate field is not empty.
              if (value == null || value.isEmpty) {
                return 'Select your date of birth';
              }
              // Check that the value length suggests a proper date format.
              if (value.length < 8) {
                return 'Maybe date format not supported';
              }
              // Update the age controller based on the current birthdate.
              widget.ageController.text =
                  calculateAge(widget.birthdateController.text);
              // Ensure the calculated age is at least 18.
              if (int.parse(widget.ageController.text) < 18) {
                return 'You must be at least 18 years old to register.';
              }
              return null;
            },
            decoration: InputDecoration(
              label: const Text('🗓️ Date of birth'),
              hintText: 'Select your date of birth',
              suffixIcon: const Icon(Icons.calendar_month),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // If an age has been calculated or a date is selected, display the age.
          if (widget.ageController.text.isNotEmpty || selectedDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${widget.name}, you are ${widget.ageController.text} years old. 😉',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
