import 'package:flutter/material.dart';
import 'package:jop_project/l10n/l10n.dart';

class PreferencesSelector extends StatefulWidget {
  
  final Function(List<String>) onPreferencesSelected;
  final List<String> initialSelectedPreferences;
  

  const PreferencesSelector({
    super.key,
    required this.onPreferencesSelected,
    this.initialSelectedPreferences = const [],
  });

  @override
  State<PreferencesSelector> createState() => _PreferencesSelectorState();
  
}

class _PreferencesSelectorState extends State<PreferencesSelector> {
  late List<String> selectedPreferences;
  

  final List<String> allPreferences = [
    
    'مكتبي',
    'عن بعد',
    'دوام جزئي',
    'دوام كامل',
  ];

  @override
  void initState() {
    super.initState();
    selectedPreferences = List.from(widget.initialSelectedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
              l10n.preferences,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...allPreferences.map((preference) => CheckboxListTile(
                  title: Text(preference),
                  value: selectedPreferences.contains(preference),
                  onChanged: (checked) {
                    setState(() {
                      if (checked!) {
                        selectedPreferences.add(preference);
                      } else {
                        selectedPreferences.remove(preference);
                      }
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
                    widget.onPreferencesSelected(selectedPreferences);
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