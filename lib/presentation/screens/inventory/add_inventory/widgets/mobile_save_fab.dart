import 'package:flutter/material.dart';

/// Modern floating action button for mobile save actions
class MobileSaveFAB extends StatefulWidget {
  const MobileSaveFAB({
    required this.onSave,
    required this.isSaving,
    this.onSaveAsDraft,
    super.key,
  });

  final VoidCallback onSave;
  final VoidCallback? onSaveAsDraft;
  final bool isSaving;

  @override
  State<MobileSaveFAB> createState() => _MobileSaveFABState();
}

class _MobileSaveFABState extends State<MobileSaveFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // Secondary action - Save as Draft
        if (widget.onSaveAsDraft != null)
          ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        widget.onSaveAsDraft!();
                        _toggleExpanded();
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.save_alt,
                              size: 20,
                              color: colorScheme.onSecondaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Save Draft',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
        
        // Main FAB
        GestureDetector(
          onLongPress: widget.onSaveAsDraft != null ? _toggleExpanded : null,
          child: FloatingActionButton.extended(
            onPressed: widget.isSaving ? null : () {
              if (_isExpanded) {
                _toggleExpanded();
              }
              widget.onSave();
            },
            backgroundColor: widget.isSaving
                ? colorScheme.surfaceContainerHighest
                : colorScheme.primary,
            elevation: 8,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: widget.isSaving
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Icon(
                      _isExpanded ? Icons.close : Icons.save,
                      color: colorScheme.onPrimary,
                    ),
            ),
            label: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                widget.isSaving
                    ? 'Saving...'
                    : _isExpanded
                        ? 'Cancel'
                        : 'Save Product',
                key: ValueKey<String>(
                  widget.isSaving
                      ? 'saving'
                      : _isExpanded
                          ? 'cancel'
                          : 'save',
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.isSaving
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}