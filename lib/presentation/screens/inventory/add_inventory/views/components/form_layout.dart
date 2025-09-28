import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';

/// Responsive form layout component that arranges form sections in columns
class FormLayout extends StatelessWidget {
  const FormLayout({
    required this.leftColumnChildren,
    required this.rightColumnChildren,
    super.key,
    this.maxWidth = 1400,
    this.horizontalPadding = 32,
    this.spacing = DoubleConstants.spacingXL,
    this.sectionSpacing = DoubleConstants.spacingL,
  });

  final List<Widget> leftColumnChildren;
  final List<Widget> rightColumnChildren;
  final double maxWidth;
  final double horizontalPadding;
  final double spacing;
  final double sectionSpacing;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Left Column - Primary Information
            Expanded(
              flex: 3,
              child: Column(
                children: _buildChildrenWithSpacing(leftColumnChildren),
              ),
            ),
            SizedBox(width: spacing),
            
            // Right Column - Secondary Information
            Expanded(
              flex: 3,
              child: Column(
                children: _buildChildrenWithSpacing(rightColumnChildren),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChildrenWithSpacing(List<Widget> children) {
    final List<Widget> spacedChildren = <Widget>[];
    
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      
      // Add spacing between children except for the last one
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(height: sectionSpacing));
      }
    }
    
    return spacedChildren;
  }
}