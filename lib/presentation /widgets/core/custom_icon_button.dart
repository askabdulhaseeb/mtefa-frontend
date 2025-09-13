import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    this.size,
    this.bgColor,
    this.padding,
    this.onPressed,
    this.borderRadius,
    super.key,
  });
  final double? size;
  final IconData icon;
  final Color? bgColor;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final Color bgColorCore = bgColor ?? Theme.of(context).primaryColor;
    final BorderRadius redius = borderRadius ?? BorderRadius.circular(6);
    final EdgeInsetsGeometry paddingValue =
        padding ?? const EdgeInsets.all(6.0);
    return Container(
      decoration: BoxDecoration(color: bgColorCore, borderRadius: redius),
      child: Material(
        color: bgColorCore,
        borderRadius: redius,
        child: InkWell(
          onTap: onPressed ?? () {},
          borderRadius: redius,
          child: Padding(
            padding: paddingValue,
            child: Icon(
              icon,
              color: Colors.white,
              size: size != null ? size! * 0.6 : 24,
            ),
          ),
        ),
      ),
    );
  }
}
