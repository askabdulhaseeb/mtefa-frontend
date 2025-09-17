import 'package:flutter/material.dart';

import '../../../../../widgets/core/enhanced_text_form_field.dart';

/// Enhanced form field with consistent styling
class EnhancedFormField extends StatelessWidget {
  const EnhancedFormField({
    required this.controller,
    required this.label,
    required this.hint,
    this.helperText,
    this.isRequired = false,
    this.keyboardType,
    this.prefixText,
    this.prefixIcon,
    this.validator,
    this.showCharacterCount = false,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? helperText;
  final bool isRequired;
  final TextInputType? keyboardType;
  final String? prefixText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool showCharacterCount;
  final int? maxLength;
  final int maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return EnhancedTextFormField(
      controller: controller,
      label: label,
      hint: hint,
      helperText: helperText,
      isRequired: isRequired,
      keyboardType: keyboardType,
      prefixText: prefixText,
      prefixIcon: prefixIcon,
      validator: validator,
      showCharacterCount: showCharacterCount,
      maxLength: maxLength,
      maxLines: maxLines,
      readOnly: readOnly,
    );
  }
}