import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/constants/numbers.dart';
import 'responsive_widget.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    required this.body, super.key,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.padding,
    this.safeArea = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final ResponsiveValue<EdgeInsets>? padding;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: ResponsiveBuilder(
        builder: (BuildContext context, DeviceType deviceType) {
          Widget content = body;
          
          // Apply responsive padding
          final EdgeInsets responsivePadding = padding?.getValue(context) ?? 
            _getDefaultPadding(context);
          
          if (responsivePadding != EdgeInsets.zero) {
            content = Padding(
              padding: responsivePadding,
              child: content,
            );
          }
          
          // Apply safe area if needed
          if (safeArea) {
            content = SafeArea(child: content);
          }
          
          // Apply responsive constraints for desktop/tablet
          if (deviceType == DeviceType.desktop) {
            content = Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1200,
                ),
                child: content,
              ),
            );
          } else if (deviceType == DeviceType.tablet) {
            content = Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 900,
                ),
                child: content,
              ),
            );
          }
          
          return content;
        },
      ),
    );
  }

  EdgeInsets _getDefaultPadding(BuildContext context) {
    switch (context.deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.all(DoubleConstants.spacingM);
      case DeviceType.tablet:
        return const EdgeInsets.all(DoubleConstants.spacingL);
      case DeviceType.desktop:
        return const EdgeInsets.all(DoubleConstants.spacingXL);
    }
  }
}

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle,
    this.toolbarHeight,
    this.automaticallyImplyLeading = true,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool? centerTitle;
  final ResponsiveValue<double>? toolbarHeight;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight?.getValue(context),
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(toolbarHeight?.mobile ?? kToolbarHeight);
  }
}

class ResponsiveDrawer extends StatelessWidget {
  const ResponsiveDrawer({
    required this.child, super.key,
    this.width,
  });

  final Widget child;
  final ResponsiveValue<double>? width;

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = width?.getValue(context) ?? 
      _getDefaultDrawerWidth(context);
    
    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: child,
      ),
    );
  }

  double _getDefaultDrawerWidth(BuildContext context) {
    switch (context.deviceType) {
      case DeviceType.mobile:
        return MediaQuery.of(context).size.width * 0.85;
      case DeviceType.tablet:
        return 320.0;
      case DeviceType.desktop:
        return 360.0;
    }
  }
}