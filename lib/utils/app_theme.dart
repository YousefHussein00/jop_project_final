import 'package:flutter/material.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/size_config.dart';

class AppTheme {
  // static const double _smallScreenWidth = 320;
  static const double _mediumScreenWidth = 600;
  static const double _largeScreenWidth = 1200;

  // النمط الفاتح
  static final ThemeData lightTheme = ThemeData(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      labelLarge: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Mulish",
      ),
      labelMedium: TextStyle(
          color: Colors.white,
          fontFamily: "Mulish",
          fontSize: (SizeConfig.screenW! <= 750) ? 18 : 22),
      labelSmall: const TextStyle(color: Colors.black54, fontSize: 14),
      titleMedium: const TextStyle(color: Colors.black, fontSize: 16),
      // bodySmall: const TextStyle(color: Colors.white, fontSize: 20),
      // headlineMedium: TextStyle(
      //     color: Colors.white,
      //     fontFamily: "Mulish",
      //     fontSize: (SizeConfig.screenW! <= 750) ? 14 : 20),
      bodyLarge: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      // displaySmall: const TextStyle(
      //     color: Color.fromARGB(255, 118, 118, 118), fontSize: 16),
      // bodyMedium: const TextStyle(
      //     color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      // displayLarge: const TextStyle(
      //     color: kPrimaryColor,
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(
      color: kBorderColor,
      applyTextScaling: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        shape: const StadiumBorder(),
        // maximumSize: Size(SizeConfig.screenW!, 56),
        // minimumSize: Size(SizeConfig.screenW!, 56),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      // focusColor: kBorderColor,
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(20)),
      //   borderSide: BorderSide(color: kBorderColor, width: 2.0),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(20)),
      //   borderSide: BorderSide(color: kBorderColor, width: 2.0),
      // ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: kBorderColor, width: 2.0),
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      hintStyle: TextStyle(
        color: kBorderColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // النمط الداكن
  static final ThemeData darkTheme = ThemeData(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      labelLarge: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Mulish",
      ),
      labelMedium: TextStyle(
          color: Colors.white,
          fontFamily: "Mulish",
          fontSize: (SizeConfig.screenW! <= 750) ? 18 : 22),
      labelSmall: const TextStyle(color: Colors.black54, fontSize: 14),
      titleMedium: const TextStyle(color: Colors.black, fontSize: 16),
      // bodySmall: const TextStyle(color: Colors.white, fontSize: 20),
      // headlineMedium: TextStyle(
      //     color: Colors.white,
      //     fontFamily: "Mulish",
      //     fontSize: (SizeConfig.screenW! <= 750) ? 14 : 20),
      bodyLarge: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      // displaySmall: const TextStyle(
      //     color: Color.fromARGB(255, 118, 118, 118), fontSize: 16),
      // bodyMedium: const TextStyle(
      //     color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      // displayLarge: const TextStyle(
      //     color: kPrimaryColor,
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(
      color: kBorderColor,
      applyTextScaling: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        shape: const StadiumBorder(),
        // maximumSize: Size(SizeConfig.screenW!, 56),
        // minimumSize: Size(SizeConfig.screenW!, 56),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      // focusColor: kBorderColor,
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(20)),
      //   borderSide: BorderSide(color: kBorderColor, width: 2.0),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(20)),
      //   borderSide: BorderSide(color: kBorderColor, width: 2.0),
      // ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: kBorderColor, width: 2.0),
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      hintStyle: TextStyle(
        color: kBorderColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // دوال مساعدة للتصميم المرن
  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < _mediumScreenWidth;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= _mediumScreenWidth &&
      MediaQuery.of(context).size.width < _largeScreenWidth;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= _largeScreenWidth;

  static double getResponsiveValue({
    required BuildContext context,
    required double small,
    required double medium,
    required double large,
  }) {
    if (isLargeScreen(context)) return large;
    if (isMediumScreen(context)) return medium;
    return small;
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    return EdgeInsets.all(
      getResponsiveValue(
        context: context,
        small: 8,
        medium: 16,
        large: 24,
      ),
    );
  }

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    return getResponsiveValue(
      context: context,
      small: baseSize,
      medium: baseSize * 1.2,
      large: baseSize * 1.4,
    );
  }
}
