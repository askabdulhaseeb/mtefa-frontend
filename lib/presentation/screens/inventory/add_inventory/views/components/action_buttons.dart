import 'package:flutter/material.dart';

/// Action buttons for save operations (draft, continue, close)
class ActionButtons extends StatelessWidget {
  const ActionButtons({
    required this.isSaving,
    super.key,
    this.onSaveDraft,
    this.onSaveAndContinue,
    this.onSaveAndClose,
  });

  final bool isSaving;
  final VoidCallback? onSaveDraft;
  final VoidCallback? onSaveAndContinue;
  final VoidCallback? onSaveAndClose;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Save as Draft button
        OutlinedButton.icon(
          onPressed: isSaving ? null : onSaveDraft,
          icon: const Icon(Icons.save_alt),
          label: const Text('Save as Draft'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Save and Continue button
        FilledButton.icon(
          onPressed: isSaving ? null : onSaveAndContinue,
          icon: isSaving
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimary,
                    ),
                  ),
                )
              : const Icon(Icons.check),
          label: Text(isSaving ? 'Saving...' : 'Save & Continue'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Save and Close button
        FilledButton.icon(
          onPressed: isSaving ? null : onSaveAndClose,
          icon: const Icon(Icons.save),
          label: const Text('Save & Close'),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}