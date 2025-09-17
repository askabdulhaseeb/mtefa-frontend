import 'package:flutter/material.dart';

import '../../../../../widgets/core/custom_dropdown_with_add.dart';

/// Reusable basic dropdown field component
class BasicDropdownField extends StatelessWidget {
  const BasicDropdownField({
    required this.title,
    required this.hint,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.onAddNew,
    required this.addNewButtonText,
    required this.addDialogTitle,
    this.isRequired = false,
    super.key,
  });

  final String title;
  final String hint;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final Future<String?> Function() onAddNew;
  final String addNewButtonText;
  final String addDialogTitle;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title.isNotEmpty) ...<Widget>[
          Row(
            children: <Widget>[
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isRequired) ...<Widget>[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        CustomDropdownWithAdd<String?>(
          title: '',
          hint: hint,
          items: items.map((String item) {
            return DropdownMenuItem<String?>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          selectedItem: selectedItem,
          onChanged: onChanged,
          onAddNew: onAddNew,
          addNewButtonText: addNewButtonText,
          addDialogTitle: addDialogTitle,
        ),
      ],
    );
  }
}