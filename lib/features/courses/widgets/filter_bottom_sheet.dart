import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(String?) onApply;

  const FilterBottomSheet({super.key, required this.onApply});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedLevel;

  List<String> levels = ["Beginner", "Intermediate", "Pro"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xff1a0000),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Filter Courses",
              style: TextStyle(color: Colors.white)),

          const SizedBox(height: 20),

          Wrap(
            spacing: 10,
            children: levels.map((level) {
              return ChoiceChip(
                label: Text(level),
                selected: selectedLevel == level,
                selectedColor: Colors.red,
                onSelected: (_) {
                  setState(() => selectedLevel = level);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              widget.onApply(selectedLevel);
              Navigator.pop(context);
            },
            child: const Text("Apply"),
          )
        ],
      ),
    );
  }
}