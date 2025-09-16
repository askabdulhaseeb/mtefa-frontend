import 'package:flutter/material.dart';

/// Visual progress indicator for form completion
class FormProgressIndicator extends StatelessWidget {
  const FormProgressIndicator({
    required this.sections,
    required this.completedSections,
    super.key,
  });

  final List<FormSection> sections;
  final Set<String> completedSections;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    final double progress = completedSections.length / sections.length;
    final int percentage = (progress * 100).round();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            colorScheme.primaryContainer.withAlpha(50),
            colorScheme.secondaryContainer.withAlpha(50),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withAlpha(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Form Progress',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getProgressColor(progress, colorScheme).withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getProgressColor(progress, colorScheme),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(progress, colorScheme),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Section indicators
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sections.map((FormSection section) {
              final bool isCompleted = completedSections.contains(section.id);
              return _SectionChip(
                section: section,
                isCompleted: isCompleted,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double progress, ColorScheme colorScheme) {
    if (progress >= 1.0) {
      return Colors.green;
    } else if (progress >= 0.75) {
      return Colors.blue;
    } else if (progress >= 0.5) {
      return Colors.orange;
    } else if (progress >= 0.25) {
      return Colors.amber;
    } else {
      return colorScheme.outline;
    }
  }
}

class _SectionChip extends StatelessWidget {
  const _SectionChip({
    required this.section,
    required this.isCompleted,
  });

  final FormSection section;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isCompleted
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? colorScheme.primary.withAlpha(100)
              : colorScheme.outline.withAlpha(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            isCompleted ? Icons.check_circle : section.icon,
            size: 14,
            color: isCompleted
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            section.title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
              color: isCompleted
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class FormSection {
  const FormSection({
    required this.id,
    required this.title,
    required this.icon,
  });

  final String id;
  final String title;
  final IconData icon;
}