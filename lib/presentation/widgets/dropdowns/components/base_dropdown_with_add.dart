import 'package:flutter/material.dart';

/// Generic dropdown widget with add functionality for inventory items
/// This base component provides consistent styling and behavior for all dropdowns
class BaseDropdownWithAdd<T> extends StatelessWidget {
  const BaseDropdownWithAdd({
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.onAdd,
    required this.itemBuilder,
    super.key,
    this.hint,
    this.isEnabled = true,
    this.validator,
    this.icon,
    this.addButtonTooltip,
  });

  final String label;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final VoidCallback onAdd;
  final String Function(T) itemBuilder;
  final String? hint;
  final bool isEnabled;
  final String? Function(T?)? validator;
  final IconData? icon;
  final String? addButtonTooltip;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label.isNotEmpty) ...<Widget>[
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: <Widget>[
            Expanded(
              child: DropdownButtonFormField<T>(
                initialValue: value,
                decoration: _buildInputDecoration(theme),
                isExpanded: true,
                items: items.map((T item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      itemBuilder(item),
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: isEnabled ? onChanged : null,
                validator: validator,
                dropdownColor: theme.colorScheme.surface,
                elevation: 8,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                menuMaxHeight: 300,
              ),
            ),
            const SizedBox(width: 8),
            _buildAddButton(theme),
          ],
        ),
        if (!isEnabled) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            'Select parent item first',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  InputDecoration _buildInputDecoration(ThemeData theme) {
    return InputDecoration(
      hintText: hint ?? 'Select $label',
      prefixIcon: icon != null ? Icon(icon) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.error),
      ),
      filled: true,
      fillColor: isEnabled 
          ? theme.colorScheme.surface 
          : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }

  Widget _buildAddButton(ThemeData theme) {
    return Material(
      color: isEnabled 
          ? theme.colorScheme.primary 
          : theme.colorScheme.outline.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: isEnabled ? onAdd : null,
        borderRadius: BorderRadius.circular(12),
        child: Tooltip(
          message: addButtonTooltip ?? 'Add new $label',
          child: Container(
            padding: const EdgeInsets.all(14),
            child: Icon(
              Icons.add,
              color: isEnabled 
                  ? theme.colorScheme.onPrimary 
                  : theme.colorScheme.outline,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}