import 'package:flutter/material.dart';

class BorderedContainerWidget extends StatelessWidget {
  const BorderedContainerWidget({
    required this.child,
    this.title = '',
    this.borderColor = Colors.grey,
    this.innerColor = Colors.transparent,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.padding,
    this.margin,
    this.boxShadow,
    super.key,
  });

  final String title;
  final Widget? child;
  final Color innerColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    Container container = Container(
      padding: padding ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: innerColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: boxShadow,
      ),
      child: child,
    );
    return Padding(
      padding: margin ?? EdgeInsets.all(8),
      child:
          title.isEmpty
              ? container
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding?.horizontal ?? 4,
                    ),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  container,
                ],
              ),
    );
  }
}
