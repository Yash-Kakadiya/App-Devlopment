import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/utils/components.dart';

class LocationOnboardingPage extends StatefulWidget {
  TextEditingController countryController;
  TextEditingController stateController;
  TextEditingController cityController;
  GlobalKey<FormState> formKey;

  LocationOnboardingPage({
    super.key,
    required this.countryController,
    required this.stateController,
    required this.cityController,
    required this.formKey,
  });

  @override
  _LocationOnboardingPageState createState() => _LocationOnboardingPageState();
}

class _LocationOnboardingPageState extends State<LocationOnboardingPage> {
  List<String> countryList = [
    "USA",
    "Canada",
    "India",
  ];
  Map<String, List<String>> statesMap = {
    "USA": ["California", "New York", "Texas"],
    "Canada": ["Ontario", "Quebec", "British Columbia"],
    "India": ["Gujarat", "Maharashtra", "Uttar Pradesh"],
  };
  Map<String, List<String>> citiesMap = {
    "California": ["Los Angeles", "San Francisco", "San Diego"],
    "New York": ["New York City", "Buffalo", "Rochester"],
    "Texas": ["Houston", "Dallas", "Austin"],
    "Ontario": ["Toronto", "Ottawa", "Mississauga"],
    "Quebec": ["Montreal", "Quebec City", "Laval"],
    "British Columbia": ["Vancouver", "Victoria", "Kelowna"],
    "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
    "Gujarat": ["Rajkot", "Ahmedabad", "Surat", "Vadodara"],
    "Uttar Pradesh": ["Ayodhya", "Prayagraj", "Mathura"],
  };

  // Currently selected values.
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    // Initialize selected values from the controllers (if any)
    if (widget.countryController.text.isNotEmpty) {
      selectedCountry = widget.countryController.text;
    }
    if (widget.stateController.text.isNotEmpty) {
      selectedState = widget.stateController.text;
    }
    if (widget.cityController.text.isNotEmpty) {
      selectedCity = widget.cityController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title texts
          const Text(
            "Where Do You Live? 🌍",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Let us know your location to help\nyou connect with the right people! 🏡",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Components.getSelectionList(
                  hintText: "Select Country",
                  options: countryList,
                  selectedValue: selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                      widget.countryController.text = value;
                      // When the country changes, clear previous state and city selections.
                      selectedState = null;
                      widget.stateController.text = "";
                      selectedCity = null;
                      widget.cityController.text = "";
                    });
                  },
                ),
                Components.getSelectionList(
                  hintText: "Select State",
                  options: selectedCountry != null
                      ? statesMap[selectedCountry]!
                      : [],
                  selectedValue: selectedState,
                  onChanged: (value) {
                    setState(() {
                      selectedState = value;
                      widget.stateController.text = value!;
                      // Clear city selection when state changes.
                      selectedCity = null;
                      widget.cityController.text = "";
                    });
                  },
                ),
                Components.getSelectionList(
                  hintText: "Select City 🏙️",
                  options:
                      selectedState != null ? citiesMap[selectedState]! : [],
                  selectedValue: selectedCity,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                      widget.cityController.text = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
