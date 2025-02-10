import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/app_colors.dart';
import '../../utils/helper_functions.dart';

class BirthdateOnboardingPage extends StatefulWidget {
  String name;
  TextEditingController birthdateController;
  String? age;
  GlobalKey<FormState> formKey;

  BirthdateOnboardingPage({
    super.key,
    required this.name,
    required this.birthdateController,
    required this.age,
    required this.formKey,
  });

  @override
  State<BirthdateOnboardingPage> createState() =>
      _BirthdateOnboardingPageState();
}

class _BirthdateOnboardingPageState extends State<BirthdateOnboardingPage> {
  DateTime? selectedDate;

  void showDatePicker() async {
    DateTime today = DateTime.now();
    // Calculate allowed date range: Users must be between 18 and 80 years old.
    DateTime lastAllowedDate =
        DateTime(today.year - 18, today.month, today.day);
    DateTime firstAllowedDate =
        DateTime(today.year - 80, today.month, today.day);

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
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'Birthday',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: CalendarDatePicker(
                  // Use lastAllowedDate as initialDate if no date is selected,
                  // ensuring it is within the allowed range.
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
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

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        widget.birthdateController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
        widget.age = calculateAge(widget.birthdateController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text
          Text(
            "${widget.name}, Your birthdate? 🎂",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          // Date input field
          TextFormField(
            readOnly: true,
            keyboardType: TextInputType.datetime,
            controller: widget.birthdateController,
            onTap: showDatePicker,
            validator: (value) {
              // Check if the field is empty or if no date was selected.
              if (value == null || value.isEmpty) {
                return 'Select your date of birth';
              }
              if (value.length < 8) {
                return 'Maybe date format not supported';
              }
              // Calculate widget.age based on the selected date.
              widget.age = calculateAge(widget.birthdateController.text);
              if (int.parse(widget.age!) < 18) {
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
          if (selectedDate != null || widget.age != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${widget.name}, you are ${widget.age} years old. 😉',
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
