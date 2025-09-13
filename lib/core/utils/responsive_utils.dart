import 'package:flutter/material.dart';
import '../constants/numbers.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveUtils {
  static DeviceType getDeviceType(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    if (screenWidth >= DoubleConstants.desktopWidth) {
      return DeviceType.desktop;
    } else if (screenWidth >= DoubleConstants.tabletWidth) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  static bool isMobileOrTablet(BuildContext context) {
    final DeviceType deviceType = getDeviceType(context);
    return deviceType == DeviceType.mobile || deviceType == DeviceType.tablet;
  }

  static bool isTabletOrDesktop(BuildContext context) {
    final DeviceType deviceType = getDeviceType(context);
    return deviceType == DeviceType.tablet || deviceType == DeviceType.desktop;
  }

  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  static double getResponsiveSpacing(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    required EdgeInsets tablet,
    required EdgeInsets desktop,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  static int getResponsiveGridColumns(
    BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  static double getResponsiveWidth(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile ?? screenWidth;
      case DeviceType.tablet:
        return tablet ?? screenWidth * 0.8;
      case DeviceType.desktop:
        return desktop ?? screenWidth * 0.6;
    }
  }

  static double getResponsiveHeight(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final double screenHeight = MediaQuery.sizeOf(context).height;

    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile ?? screenHeight;
      case DeviceType.tablet:
        return tablet ?? screenHeight * 0.9;
      case DeviceType.desktop:
        return desktop ?? screenHeight * 0.8;
    }
  }
}

extension ResponsiveExtension on BuildContext {
  DeviceType get deviceType => ResponsiveUtils.getDeviceType(this);
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isMobileOrTablet => ResponsiveUtils.isMobileOrTablet(this);
  bool get isTabletOrDesktop => ResponsiveUtils.isTabletOrDesktop(this);

  double responsiveFontSize({
    required double mobile,
    required double tablet,
    required double desktop,
  }) => ResponsiveUtils.getResponsiveFontSize(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );

  double responsiveSpacing({
    required double mobile,
    required double tablet,
    required double desktop,
  }) => ResponsiveUtils.getResponsiveSpacing(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );

  EdgeInsets responsivePadding({
    required EdgeInsets mobile,
    required EdgeInsets tablet,
    required EdgeInsets desktop,
  }) => ResponsiveUtils.getResponsivePadding(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );

  int responsiveGridColumns({
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) => ResponsiveUtils.getResponsiveGridColumns(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );

  double responsiveWidth({double? mobile, double? tablet, double? desktop}) =>
      ResponsiveUtils.getResponsiveWidth(
        this,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
      );

  double responsiveHeight({double? mobile, double? tablet, double? desktop}) =>
      ResponsiveUtils.getResponsiveHeight(
        this,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
      );
}
