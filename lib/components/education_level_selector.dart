import 'package:flutter/material.dart';
import 'package:jop_project/l10n/l10n.dart';

class EducationLevelSelector extends StatefulWidget {
  final Function(String) onLevelSelected;
  final String initialSelectedLevel;

  const EducationLevelSelector({
    super.key,
    required this.onLevelSelected,
    this.initialSelectedLevel = '',
  });

  @override
  State<EducationLevelSelector> createState() => _EducationLevelSelectorState();
}

class _EducationLevelSelectorState extends State<EducationLevelSelector> {
  late String selectedLevel;

  final List<String> educationLevels = [
    'ثانوية',
    'بكالوريوس',
    'ماجستير',
    'دكتوراه',
    'لايوجد',
  ];

  @override
  void initState() {
    super.initState();
    selectedLevel = widget.initialSelectedLevel;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding:  const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
              l10n.educationLevel,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...educationLevels.map((level) => RadioListTile(
                  title: Text(level),
                  value: level,
                  groupValue: selectedLevel,
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value.toString();
                    });
                  },
                )),
             const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:  Text(l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onLevelSelected(selectedLevel);
                    Navigator.pop(context);
                  },
                  child:  Text(l10n.ok),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 