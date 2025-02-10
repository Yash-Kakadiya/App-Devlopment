import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';

class HeightWeightOnboardingPage extends StatefulWidget {
  String gender;
  String heightController;
  String weightController;

  HeightWeightOnboardingPage({
    super.key,
    required this.gender,
    required this.heightController,
    required this.weightController,
  });

  @override
  _HeightWeightOnboardingPageState createState() =>
      _HeightWeightOnboardingPageState();
}

class _HeightWeightOnboardingPageState
    extends State<HeightWeightOnboardingPage> {
  List<String> heightOptions = [
    "7'0 ft",
    "6'11 ft",
    "6'10 ft",
    "6'9 ft",
    "6'8 ft",
    "6'7 ft",
    "6'6 ft",
    "6'5 ft",
    "6'4 ft",
    "6'3 ft",
    "6'2 ft",
    "6'1 ft",
    "6'0 ft",
    "5'11 ft",
    "5'10 ft",
    "5'9 ft",
    "5'8 ft",
    "5'7 ft",
    "5'6 ft",
    "5'5 ft",
    "5'4 ft",
    "5'3 ft",
    "5'2 ft",
    "5'1 ft",
    "5'0 ft",
  ];

  // Generate weight options from 40 kg to 150 kg
  List<String> weightOptions =
      List.generate(150 - 40 + 1, (index) => '${40 + index} kg');

  int selectedHeightIndex = 19; // Default height: 5'5 ft
  int selectedWeightIndex = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int hIdx = heightOptions.indexOf(widget.heightController);
    selectedHeightIndex = hIdx == -1 ? 19 : hIdx;
    int wIdx = weightOptions.indexOf(widget.weightController);
    selectedWeightIndex = wIdx == -1 ? 15 : wIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            "What's your height & weight?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Image.asset(
                      widget.gender == 'male'
                          ? "assets/images/male_full.png"
                          : "assets/images/female_full.png", // Make sure to add your avatar image in assets
                      // fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Scrollable Height
                getHeightPicker(),
              ],
            ),
          ),
          getWeightPicker(),
        ],
      ),
    );
  }

  // Default weight: 55 kg

  Widget getHeightPicker() {
    return SizedBox(
      height: 450, // Fixed height for picker effect
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
            widget.heightController = heightOptions[selectedHeightIndex];
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
                decoration: isSelected
                    ? const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.primary, // Choose your color
                            width: 2.0, // Choose your width
                          ),
                          bottom: BorderSide(
                            color: AppColors
                                .primary, // Same or different color as needed
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

  Widget getWeightPicker() {
    return SizedBox(
      height: 100, // Adjust the height for the horizontal picker
      width: 350, // Adjust the width for the horizontal picker effect
      child: RotatedBox(
        quarterTurns:
            3, // Rotate the entire ListWheelScrollView to make it horizontal
        child: ListWheelScrollView.useDelegate(
          itemExtent: 80,
          physics: const FixedExtentScrollPhysics(),
          perspective: 0.003,
          diameterRatio: 1.5,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedWeightIndex = index;
              widget.weightController = weightOptions[selectedWeightIndex];
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
                    -3, // Rotate each child back to its normal orientation
                child: Center(
                  child: Container(
                    decoration: isSelected
                        ? const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors
                                    .primary, // Customize the color as needed
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
