import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    switch (context.deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, context.deviceType);
  }
}

class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final T mobile;
  final T? tablet;
  final T? desktop;

  T getValue(BuildContext context) {
    switch (context.deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.alignment,
    this.constraints,
    this.decoration,
  });

  final Widget child;
  final ResponsiveValue<EdgeInsets>? padding;
  final ResponsiveValue<EdgeInsets>? margin;
  final ResponsiveValue<double>? width;
  final ResponsiveValue<double>? height;
  final ResponsiveValue<Alignment>? alignment;
  final ResponsiveValue<BoxConstraints>? constraints;
  final ResponsiveValue<Decoration>? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding?.getValue(context),
      margin: margin?.getValue(context),
      width: width?.getValue(context),
      height: height?.getValue(context),
      alignment: alignment?.getValue(context),
      constraints: constraints?.getValue(context),
      decoration: decoration?.getValue(context),
      child: child,
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.columns,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.padding,
  });

  final List<Widget> children;
  final ResponsiveValue<int> columns;
  final double spacing;
  final double runSpacing;
  final ResponsiveValue<EdgeInsets>? padding;

  @override
  Widget build(BuildContext context) {
    final int columnCount = columns.getValue(context);
    final EdgeInsets containerPadding = padding?.getValue(context) ?? EdgeInsets.zero;

    return Padding(
      padding: containerPadding,
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children.map((Widget child) {
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 
                   containerPadding.horizontal - 
                   (spacing * (columnCount - 1))) / columnCount,
            child: child,
          );
        }).toList(),
      ),
    );
  }
}

class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final ResponsiveValue<TextStyle> style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.getValue(context),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class ResponsiveSizedBox extends StatelessWidget {
  const ResponsiveSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  const ResponsiveSizedBox.width(
    this.width, {
    super.key,
    this.child,
  }) : height = null;

  const ResponsiveSizedBox.height(
    this.height, {
    super.key,
    this.child,
  }) : width = null;

  final ResponsiveValue<double>? width;
  final ResponsiveValue<double>? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.getValue(context),
      height: height?.getValue(context),
      child: child,
    );
  }
}