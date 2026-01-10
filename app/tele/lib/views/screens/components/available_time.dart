import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AvailableTimeWidget extends StatelessWidget {
  final List<String> availableTimes;
  final int? selectedIndex;
  final Function(int) onTimeSelected;

  const AvailableTimeWidget({
    super.key,
    required this.availableTimes,
    required this.selectedIndex,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "available_time".tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5,
            children: List.generate(availableTimes.length, (index) {
              return ChoiceChip(
                checkmarkColor: Colors.white,
                label: Text(
                  availableTimes[index],
                  style: TextStyle(
                    color:
                        selectedIndex == index ? Colors.white : Colors.black54,
                  ),
                ),
                selected: selectedIndex == index,
                onSelected: (bool selected) {
                  onTimeSelected(selected ? index : selectedIndex ?? 0);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                selectedColor: Color.fromARGB(255, 9, 130, 13),
              );
            }),
          ),
        ],
      ),
    );
  }
}