import 'package:flutter/material.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/size_config.dart';

class AppTheme {
  // static const double _smallScreenWidth = 320;
  static const double _mediumScreenWidth = 600;
  static const double _largeScreenWidth = 1200;

  // ألوان التطبيق الأساسية
  // static const Color _primaryLight = Color(0xFF6200EE);
  static const Color _primaryDark = Color(0xFFBB86FC);
  // static const Color _secondaryLight = Color(0xFF03DAC6);
  static const Color _secondaryDark = Color(0xFF03DAC6);
  // static const Color _errorLight = Color(0xFFB00020);
  static const Color _errorDark = Color(0xFFCF6679);
  static const Color _backgroundLight = Color(0xFFFAFAFA);
  static const Color _backgroundDark = Color(0xFF121212);
  // static const Color _surfaceLight = Colors.white;
  static const Color _surfaceDark = Color(0xFF1E1E1E);

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
      // bodyLarge: const TextStyle(
      //     color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
    useMaterial3: true,
    tabBarTheme: const TabBarTheme(
      labelColor: _backgroundLight,
      unselectedLabelColor: _primaryDark,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: _primaryDark,
          width: 2.0,
        )),
        color: Color.fromARGB(27, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      // labelPadding: EdgeInsets.only(left: 4.0, right: 4.0),
    ),
    brightness: Brightness.dark,
    primaryColor: _primaryDark,
    colorScheme: const ColorScheme.dark(
      primary: _primaryDark,
      secondary: _secondaryDark,
      error: _errorDark,
      surface: _surfaceDark,
    ),
    scaffoldBackgroundColor: _backgroundDark,
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: _surfaceDark,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryDark,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryDark),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _errorDark),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
