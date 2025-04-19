import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';

import '../../core/app_constants.dart';

/// A stateful widget that displays the height and weight selection onboarding page.
/// This page allows the user to select their height and weight using scrollable pickers.
/// The selected values are stored in the provided [TextEditingController]s.
class HeightWeightOnboardingPage extends StatefulWidget {
  /// The user's gender (used to determine which avatar image to display).
  final String gender;

  /// Controller to store the selected height.
  final TextEditingController heightController;

  /// Controller to store the selected weight.
  final TextEditingController weightController;

  /// Creates a [HeightWeightOnboardingPage] widget.
  const HeightWeightOnboardingPage({
    super.key,
    required this.gender,
    required this.heightController,
    required this.weightController,
  });

  @override
  State<HeightWeightOnboardingPage> createState() =>
      _HeightWeightOnboardingPageState();
}

/// State class for [HeightWeightOnboardingPage] that builds the UI and manages picker selections.
class _HeightWeightOnboardingPageState
    extends State<HeightWeightOnboardingPage> {
  // List of height options represented as strings.
  List<String> heightOptions = HEIGHT_OPTIONS;

  // Generate weight options from 40 kg to 150 kg.
  List<String> weightOptions =
      List.generate(150 - 40 + 1, (index) => '${40 + index} kg');

  // Default selected indices for height and weight.
  // Default height index 19 corresponds to "5'5 ft".
  int selectedHeightIndex = 19;
  // Default weight index 15 (which corresponds to "55 kg" if weightOptions[15] is "55 kg").
  int selectedWeightIndex = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Determine the initial selected index for height based on the text in the heightController.
    int hIdx = heightOptions.indexOf(widget.heightController.text);
    selectedHeightIndex = hIdx == -1 ? 19 : hIdx;
    // Determine the initial selected index for weight based on the text in the weightController.
    int wIdx = weightOptions.indexOf(widget.weightController.text);
    selectedWeightIndex = wIdx == -1 ? 15 : wIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // The form is used to group the input fields together.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text prompting the user to select their height and weight.
          const Text(
            "What's your height & weight?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          // Expanded widget to allow the upper part of the screen to be flexible.
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display an avatar image based on the user's gender.
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Image.asset(
                      widget.gender == 'male'
                          ? "assets/images/male_full.png"
                          : "assets/images/female_full.png", // Make sure to add your avatar image in assets.
                      // fit: BoxFit.contain,  // Uncomment and adjust if needed.
                    ),
                  ),
                ),
                // Height picker widget.
                getHeightPicker(),
              ],
            ),
          ),
          // Weight picker widget displayed below the Row.
          getWeightPicker(),
        ],
      ),
    );
  }

  /// Builds a vertical height picker using a [ListWheelScrollView].
  /// The picker displays a list of height options, and the selected option
  /// updates the [heightController].
  Widget getHeightPicker() {
    return SizedBox(
      height: 450, // Fixed height for the picker effect.
      width: 100,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.003,
        diameterRatio: 1.5,
        onSelectedItemChanged: (index) {
          setState(() {
            print('Height change');
            selectedHeightIndex = index;
            widget.heightController.text = heightOptions[selectedHeightIndex];
          });
        },
        controller: FixedExtentScrollController(
          initialItem: selectedHeightIndex,
        ),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: heightOptions.length,
          builder: (context, index) {
            bool isSelected = (index == selectedHeightIndex);
            return Center(
              child: Container(
                // If the current item is selected, add a border at the top and bottom.
                decoration: isSelected
                    ? const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.primary, // Color for the border.
                            width: 2.0, // Border width.
                          ),
                          bottom: BorderSide(
                            color: AppColors
                                .primary, // Border color (can be same or different).
                            width: 2.0,
                          ),
                        ),
                      )
                    : null,
                child: Text(
                  heightOptions[index],
                  style: TextStyle(
                    fontSize: isSelected ? 24 : 18,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.primary : Colors.grey[400],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds a horizontal weight picker using a rotated [ListWheelScrollView].
  /// The weight picker displays a list of weight options horizontally.
  /// The selected option updates the [weightController].
  Widget getWeightPicker() {
    return SizedBox(
      height: 100, // Fixed height for the horizontal picker.
      width: 350, // Fixed width for the horizontal picker effect.
      child: RotatedBox(
        quarterTurns:
            3, // Rotate the entire ListWheelScrollView to display it horizontally.
        child: ListWheelScrollView.useDelegate(
          itemExtent: 80,
          physics: const FixedExtentScrollPhysics(),
          perspective: 0.003,
          diameterRatio: 1.5,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedWeightIndex = index;
              widget.weightController.text = weightOptions[selectedWeightIndex];
            });
          },
          controller: FixedExtentScrollController(
            initialItem: selectedWeightIndex,
          ),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: weightOptions.length,
            builder: (context, index) {
              bool isSelected = (index == selectedWeightIndex);
              return RotatedBox(
                quarterTurns:
                    -3, // Rotate each child back to its normal orientation.
                child: Center(
                  child: Container(
                    // If the item is selected, add a border on the left and right.
                    decoration: isSelected
                        ? const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors
                                    .primary, // Customize the border color.
                                width: 2.0,
                              ),
                              right: BorderSide(
                                color: AppColors.primary,
                                width: 2.0,
                              ),
                            ),
                          )
                        : null,
                    child: Text(
                      weightOptions[index],
                      style: TextStyle(
                        fontSize: isSelected ? 24 : 18,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected ? AppColors.primary : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
