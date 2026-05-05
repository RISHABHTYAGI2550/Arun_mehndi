import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? selectedLevel;
  final Function(String?) onApply;
  final VoidCallback onClear;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    required this.onClear,
    this.selectedLevel,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedLevel;

  final List<Map<String, dynamic>> levels = [
    {"label": "Beginner", "icon": Icons.sentiment_satisfied_alt, "color": Colors.green},
    {"label": "Intermediate", "icon": Icons.trending_up, "color": Colors.orange},
    {"label": "Pro", "icon": Icons.workspace_premium, "color": Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.selectedLevel; // ✅ current selection restore
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white, // ✅ light mode
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ─── HANDLE BAR ──────────────────────────────
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // ─── HEADER ──────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter Courses",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // ✅ Clear button
              if (_selectedLevel != null)
                GestureDetector(
                  onTap: () {
                    setState(() => _selectedLevel = null);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          // ─── LEVEL LABEL ─────────────────────────────
          Text(
            "Difficulty Level",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 12),

          // ─── LEVEL OPTIONS ───────────────────────────
          Column(
            children: levels.map((level) {
              final isSelected = _selectedLevel == level["label"];
              final color = level["color"] as Color;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    // ✅ Same tap = deselect
                    _selectedLevel =
                    isSelected ? null : level["label"] as String;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withOpacity(0.08)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? color : Colors.grey.shade200,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          level["icon"] as IconData,
                          color: color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Label
                      Expanded(
                        child: Text(
                          level["label"] as String,
                          style: TextStyle(
                            color: isSelected ? color : Colors.black87,
                            fontSize: 15,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),

                      // Check icon
                      if (isSelected)
                        Icon(Icons.check_circle, color: color, size: 20)
                      else
                        Icon(Icons.radio_button_unchecked,
                            color: Colors.grey.shade300, size: 20),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // ─── APPLY BUTTON ─────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (_selectedLevel == null) {
                  widget.onClear();
                } else {
                  widget.onApply(_selectedLevel);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                _selectedLevel == null ? "Show All Courses" : "Apply Filter",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}