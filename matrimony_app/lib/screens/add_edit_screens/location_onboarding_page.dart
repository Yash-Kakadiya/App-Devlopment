import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/utils/components.dart';

import '../../core/app_constants.dart';

/// A stateful widget for the location onboarding page.
/// This page collects the user's location details (country, state, and city)
/// through a series of dropdown selection lists.
class LocationOnboardingPage extends StatefulWidget {
  /// Controller for the country field.
  final TextEditingController countryController;

  /// Controller for the state field.
  final TextEditingController stateController;

  /// Controller for the city field.
  final TextEditingController cityController;

  /// Global key for the form on this page.
  final GlobalKey<FormState> formKey;

  /// Creates a [LocationOnboardingPage] widget.
  const LocationOnboardingPage({
    super.key,
    required this.countryController,
    required this.stateController,
    required this.cityController,
    required this.formKey,
  });

  @override
  State<LocationOnboardingPage> createState() => _LocationOnboardingPageState();
}

/// State class for [LocationOnboardingPage] that builds the UI and handles selection changes.
class _LocationOnboardingPageState extends State<LocationOnboardingPage> {
  // List of available countries.
  List<String> countryList = COUNTRY_LIST;

  // Map of states for each country.
  Map<String, List<String>> statesMap = STATES_MAP;

  // Map of cities for each state.
  Map<String, List<String>> citiesMap = CITIES_MAP;

  // Currently selected country, state, and city.
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    // Initialize selected values from the controllers, if they already contain text.
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
      // Attach the form key provided from the parent.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text asking for the user's location.
          const Text(
            "Where Do You Live? 🌍",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle text providing additional context.
          const Text(
            "Let us know your location to help\nyou connect with the right people! 🏡",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          // Expanded widget to fill available vertical space.
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Country selection dropdown using a custom selection list component.
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
                // State selection dropdown. Options depend on the selected country.
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
                // City selection dropdown. Options depend on the selected state.
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
