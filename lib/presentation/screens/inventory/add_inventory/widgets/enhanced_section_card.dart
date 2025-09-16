import 'package:flutter/material.dart';

/// Enhanced section card with modern Material 3 design
class EnhancedSectionCard extends StatefulWidget {
  const EnhancedSectionCard({
    required this.icon,
    required this.title,
    required this.child,
    this.subtitle,
    this.isRequired = false,
    this.isExpanded = true,
    this.backgroundColor,
    this.iconColor,
    this.onExpansionChanged,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget child;
  final bool isRequired;
  final bool isExpanded;
  final Color? backgroundColor;
  final Color? iconColor;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<EnhancedSectionCard> createState() => _EnhancedSectionCardState();
}

class _EnhancedSectionCardState extends State<EnhancedSectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;
  bool _isExpanded = true;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(_expandAnimation);
    
    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    // Determine card colors based on theme and state
    final Color backgroundColor = widget.backgroundColor ??
        (theme.brightness == Brightness.light
            ? colorScheme.surface
            : colorScheme.surfaceContainerHighest);
    
    final Color iconBackgroundColor = widget.iconColor?.withAlpha(30) ??
        colorScheme.primary.withAlpha(30);
    
    final Color iconColor = widget.iconColor ?? colorScheme.primary;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? colorScheme.primary.withAlpha(60)
                : colorScheme.outline.withAlpha(30),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: colorScheme.shadow.withAlpha(_isHovered ? 15 : 8),
              blurRadius: _isHovered ? 12 : 8,
              offset: Offset(0, _isHovered ? 4 : 2),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            // Header Section
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _handleTap,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      // Icon with background
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: iconBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.icon,
                          size: 20,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title and subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  widget.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                if (widget.isRequired) ...<Widget>[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.error.withAlpha(30),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Required',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.error,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if (widget.subtitle != null) ...<Widget>[
                              const SizedBox(height: 2),
                              Text(
                                widget.subtitle!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Expansion arrow
                      RotationTransition(
                        turns: _rotationAnimation,
                        child: Icon(
                          Icons.expand_more,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Content Section with animation
            SizeTransition(
              sizeFactor: _expandAnimation,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}