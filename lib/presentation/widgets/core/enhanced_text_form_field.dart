import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enhanced text form field with modern Material 3 design
class EnhancedTextFormField extends StatefulWidget {
  const EnhancedTextFormField({
    required this.controller,
    required this.label,
    this.hint,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.autofocus = false,
    this.filled = true,
    this.isRequired = false,
    this.showCharacterCount = false,
    this.onTap,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final bool autofocus;
  final bool filled;
  final bool isRequired;
  final bool showCharacterCount;
  final VoidCallback? onTap;

  @override
  State<EnhancedTextFormField> createState() => _EnhancedTextFormFieldState();
}

class _EnhancedTextFormFieldState extends State<EnhancedTextFormField> {
  bool _isFocused = false;
  bool _hasError = false;
  String? _errorText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    if (_hasError && widget.validator != null) {
      final String? error = widget.validator!(widget.controller.text);
      setState(() {
        _hasError = error != null;
        _errorText = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    // Determine field colors based on state
    final Color borderColor = _hasError
        ? colorScheme.error
        : _isFocused
            ? colorScheme.primary
            : colorScheme.outline.withAlpha(100);
    
    final Color fillColor = widget.filled
        ? (_isFocused
            ? colorScheme.primaryContainer.withAlpha(20)
            : colorScheme.surfaceContainerHighest.withAlpha(50))
        : Colors.transparent;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Label with required indicator
        if (widget.label.isNotEmpty) ...<Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: _hasError
                      ? colorScheme.error
                      : _isFocused
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                ),
              ),
              if (widget.isRequired) ...<Widget>[
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
        
        // Text field with enhanced styling
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isFocused
                ? <BoxShadow>[
                    BoxShadow(
                      color: colorScheme.primary.withAlpha(40),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : <BoxShadow>[],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            obscureText: widget.obscureText,
            autofocus: widget.autofocus,
            onTap: widget.onTap,
            onChanged: (String value) {
              widget.onChanged?.call(value);
              if (widget.showCharacterCount) {
                setState(() {}); // Rebuild to update character count
              }
            },
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: (String? value) {
              final String? error = widget.validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _hasError = error != null;
                    _errorText = error;
                  });
                }
              });
              return error;
            },
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant.withAlpha(150),
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: IconTheme(
                        data: IconThemeData(
                          color: _isFocused
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        child: widget.prefixIcon!,
                      ),
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: IconTheme(
                        data: IconThemeData(
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        child: widget.suffixIcon!,
                      ),
                    )
                  : null,
              prefixText: widget.prefixText,
              suffixText: widget.suffixText,
              prefixStyle: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              suffixStyle: TextStyle(
                color: colorScheme.onSurfaceVariant,
              ),
              filled: widget.filled,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.outline.withAlpha(100),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.outline.withAlpha(50),
                  width: 1,
                ),
              ),
              counterText: '',
              errorText: null, // We handle error display separately
            ),
          ),
        ),
        
        // Helper text or error message
        if (_errorText != null || widget.helperText != null || widget.showCharacterCount) ...<Widget>[
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _errorText ?? widget.helperText ?? '',
                    key: ValueKey<String?>(_errorText ?? widget.helperText),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _errorText != null
                          ? colorScheme.error
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              if (widget.showCharacterCount && widget.maxLength != null) ...<Widget>[
                Text(
                  '${widget.controller.text.length}/${widget.maxLength}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: widget.controller.text.length >= widget.maxLength!
                        ? colorScheme.error
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}