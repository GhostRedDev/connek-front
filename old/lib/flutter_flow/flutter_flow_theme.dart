// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';

SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color bg1Sec;
  late Color bg2Sec;
  late Color secondaryAlpha500;
  late Color primary200;
  late Color secondary300;
  late Color neutral100;
  late Color secondary100;
  late Color secondaryAlpha10;
  late Color secondaryAlpha20;
  late Color secondaryAlpha30;
  late Color green400;
  late Color primary100;
  late Color neutralAlpha40;
  late Color green600;
  late Color secondary200;
  late Color green200;
  late Color green500;
  late Color yellow100;
  late Color secondary400;
  late Color primaryAlpha10;
  late Color secondary500;
  late Color green100;
  late Color neutralAlpha50;
  late Color greenAlpha10;
  late Color red400;
  late Color red300;
  late Color yellowAlpha10;
  late Color greenAlpha102;
  late Color customColor29;
  late Color primaryAlpha20;
  late Color primaryAlpha30;
  late Color customColor32;
  late Color primary300;
  late Color greenAlpha25;
  late Color neutral900;
  late Color primaryAlpha400;
  late Color greenAlpha50;
  late Color customColor38;
  late Color customColor39;
  late Color customColor40;
  late Color customColor41;
  late Color customColor42;
  late Color customColor43;
  late Color customColor44;
  late Color customColor45;
  late Color customColor46;
  late Color customColor47;
  late Color customColor48;
  late Color customColor49;
  late Color customColor50;
  late Color customColor51;
  late Color primary400;
  late Color primary500;
  late Color primaryAlpha500;
  late Color secondaryAlpha40;
  late Color neutral200;
  late Color neutral300;
  late Color neutral400;
  late Color neutral500;
  late Color nonSelection;
  late Color neutral700;
  late Color neutral800;
  late Color neutralAlpha10;
  late Color neutral1000;
  late Color neutralAlpha20;
  late Color neutralAlpha30;
  late Color red100;
  late Color red200;
  late Color redAlpha10;
  late Color red500;
  late Color red600;
  late Color redAlpha25;
  late Color redAlpha40;
  late Color redAlpha50;
  late Color yellow200;
  late Color customColor77;
  late Color customColor78;
  late Color primaryMainColor;
  late Color navBg;
  late Color white;
  late Color customColor79;
  late Color customColor1;
  late Color customColor2;
  late Color customColor3;
  late Color customColor4;
  late Color customColor5;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color bg1Sec = const Color(0xFFFFFFFF);
  late Color bg2Sec = const Color(0x66E2E2E2);
  late Color secondaryAlpha500 = const Color(0x80C4C4C4);
  late Color primary200 = const Color(0xFF3E8EFF);
  late Color secondary300 = const Color(0xFF565656);
  late Color neutral100 = const Color(0xFF0D1B2A);
  late Color secondary100 = const Color(0xFFE2E2E2);
  late Color secondaryAlpha10 = const Color(0x199F9F9F);
  late Color secondaryAlpha20 = const Color(0x34C4C4C4);
  late Color secondaryAlpha30 = const Color(0x4CC4C4C4);
  late Color green400 = const Color(0xFF007048);
  late Color primary100 = const Color(0xFF046CFF);
  late Color neutralAlpha40 = const Color(0x660D1B2A);
  late Color green600 = const Color(0xFF007048);
  late Color secondary200 = const Color(0xFF7B7B7B);
  late Color green200 = const Color(0xFF1FC16B);
  late Color green500 = const Color(0xFF00C67F);
  late Color yellow100 = const Color(0xFFFFDB43);
  late Color secondary400 = const Color(0xFF7B7B7B);
  late Color primaryAlpha10 = const Color(0x323E8EFF);
  late Color secondary500 = const Color(0xFF565656);
  late Color green100 = const Color(0xFF84EBB4);
  late Color neutralAlpha50 = const Color(0x800D1B2A);
  late Color greenAlpha10 = const Color(0x191FC16B);
  late Color red400 = const Color(0xFFFB3748);
  late Color red300 = const Color(0xFFFFA5A5);
  late Color yellowAlpha10 = const Color(0x34FFDB43);
  late Color greenAlpha102 = const Color(0xFF00C67F);
  late Color customColor29 = const Color(0xFF63FFC7);
  late Color primaryAlpha20 = const Color(0x323E8EFF);
  late Color primaryAlpha30 = const Color(0x4C3E8EFF);
  late Color customColor32 = const Color(0xFF00C67F);
  late Color primary300 = const Color(0xFF003B8E);
  late Color greenAlpha25 = const Color(0x3E00C67F);
  late Color neutral900 = const Color(0xFF150815);
  late Color primaryAlpha400 = const Color(0x663E8EFF);
  late Color greenAlpha50 = const Color(0x8000C67F);
  late Color customColor38 = const Color(0xFFE5E5E5);
  late Color customColor39 = const Color(0xFFFFFFFF);
  late Color customColor40 = const Color(0xFFF0F8FF);
  late Color customColor41 = const Color(0xFF1C1C1C);
  late Color customColor42 = const Color(0xFFFFFFFF);
  late Color customColor43 = const Color(0xFF7F7F7F);
  late Color customColor44 = const Color(0xFF009FF5);
  late Color customColor45 = const Color(0xFFD9F1FD);
  late Color customColor46 = const Color(0xFF53BDF5);
  late Color customColor47 = const Color(0xFF0083C9);
  late Color customColor48 = const Color(0xFFAAB9C5);
  late Color customColor49 = const Color(0xFFE7EBEF);
  late Color customColor50 = const Color(0xFFC2CDD6);
  late Color customColor51 = const Color(0xFF92A5B5);
  late Color primary400 = const Color(0xFF0053C8);
  late Color primary500 = const Color(0xFF003B8E);
  late Color primaryAlpha500 = const Color(0x803E8EFF);
  late Color secondaryAlpha40 = const Color(0xFFC4C4C4);
  late Color neutral200 = const Color(0xFFE2DEDE);
  late Color neutral300 = const Color(0xFFC8BABA);
  late Color neutral400 = const Color(0xFFB39293);
  late Color neutral500 = const Color(0xFFA06669);
  late Color nonSelection = const Color(0xFF82474C);
  late Color neutral700 = const Color(0xFF5F2D34);
  late Color neutral800 = const Color(0xFF381820);
  late Color neutralAlpha10 = const Color(0x190D1B2A);
  late Color neutral1000 = const Color(0xFF0D1B2A);
  late Color neutralAlpha20 = const Color(0x330D1B2A);
  late Color neutralAlpha30 = const Color(0x4C0D1B2A);
  late Color red100 = const Color(0xFFFB3748);
  late Color red200 = const Color(0xFFD00416);
  late Color redAlpha10 = const Color(0xFFFF4B4B);
  late Color red500 = const Color(0xFFFE0000);
  late Color red600 = const Color(0xFFB20000);
  late Color redAlpha25 = const Color(0xFFFF4B4B);
  late Color redAlpha40 = const Color(0xFFFF4B4B);
  late Color redAlpha50 = const Color(0xFFFF4B4B);
  late Color yellow200 = const Color(0xFFDFB400);
  late Color customColor77 = const Color(0xFF7F7F7F);
  late Color customColor78 = const Color(0xFF000000);
  late Color primaryMainColor = const Color(0xFF3E7BFA);
  late Color navBg = const Color(0x4CE2E2E2);
  late Color white = const Color(0xFFFFFFFF);
  late Color customColor79 = const Color(0xFFB189E6);
  late Color customColor1 = const Color(0xFFD011D3);
  late Color customColor2 = const Color(0xFF9E9C84);
  late Color customColor3 = const Color(0xFF667A76);
  late Color customColor4 = const Color(0xFF232158);
  late Color customColor5 = const Color(0xFF4E6057);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Outfit';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 46.0,
      );
  String get displayMediumFamily => 'Outfit';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 38.0,
      );
  String get displaySmallFamily => 'Outfit';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
      );
  String get headlineLargeFamily => 'Outfit';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 26.0,
      );
  String get headlineMediumFamily => 'Outfit';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      );
  String get headlineSmallFamily => 'Outfit';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Outfit';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get titleMediumFamily => 'Outfit';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Outfit';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Inter';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.inter(
        color: theme.secondary300,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Inter';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.inter(
        color: theme.secondary300,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Inter';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.inter(
        color: theme.secondary300,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Inter';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );
  String get bodyMediumFamily => 'Inter';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get bodySmallFamily => 'Inter';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF046CFF);
  late Color secondary = const Color(0xFF0053C8);
  late Color tertiary = const Color(0xFF003B8E);
  late Color alternate = const Color(0xFF565656);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFFC4C4C4);
  late Color primaryBackground = const Color(0xFF14161A);
  late Color secondaryBackground = const Color(0xF0121417);
  late Color accent1 = const Color(0xFFFFFFFF);
  late Color accent2 = const Color(0xFFE2E2E2);
  late Color accent3 = const Color(0xFFC4C4C4);
  late Color accent4 = const Color(0xFF9F9F9F);
  late Color success = const Color(0xFF00C67F);
  late Color warning = const Color(0xFFFFDB43);
  late Color error = const Color(0xFFFF4B4B);
  late Color info = const Color(0xFFFFFFFF);

  late Color bg1Sec = const Color(0xFF14161A);
  late Color bg2Sec = const Color(0xEF121417);
  late Color secondaryAlpha500 = const Color(0x7FC4C4C4);
  late Color primary200 = const Color(0xFF3E8EFF);
  late Color secondary300 = const Color(0xFF9F9F9F);
  late Color neutral100 = const Color(0xFFFFFFFF);
  late Color secondary100 = const Color(0xFFE2E2E2);
  late Color secondaryAlpha10 = const Color(0x19C4C4C4);
  late Color secondaryAlpha20 = const Color(0x34C4C4C4);
  late Color secondaryAlpha30 = const Color(0x4CC4C4C4);
  late Color green400 = const Color(0xFF15FFAB);
  late Color primary100 = const Color(0xFF9FC7FF);
  late Color neutralAlpha40 = const Color(0x650D1B2A);
  late Color green600 = const Color(0xFF007048);
  late Color secondary200 = const Color(0xFFC4C4C4);
  late Color green200 = const Color(0xFF1FC16B);
  late Color green500 = const Color(0xFF00C67F);
  late Color yellow100 = const Color(0xFFFFDB43);
  late Color secondary400 = const Color(0xFF7B7B7B);
  late Color primaryAlpha10 = const Color(0x193E8EFF);
  late Color secondary500 = const Color(0xFF565656);
  late Color green100 = const Color(0xFF84EBB4);
  late Color neutralAlpha50 = const Color(0x800D1B2A);
  late Color greenAlpha10 = const Color(0x191FC16B);
  late Color red400 = const Color(0xFFFF4B4B);
  late Color red300 = const Color(0xFFFFA5A5);
  late Color yellowAlpha10 = const Color(0x19FFDB43);
  late Color greenAlpha102 = const Color(0x1900C67F);
  late Color customColor29 = const Color(0xFF63FFC7);
  late Color primaryAlpha20 = const Color(0x333E8EFF);
  late Color primaryAlpha30 = const Color(0x4D3E8EFF);
  late Color customColor32 = const Color(0x6500C67F);
  late Color primary300 = const Color(0xFF046CFF);
  late Color greenAlpha25 = const Color(0x3200C67F);
  late Color neutral900 = const Color(0xFF150815);
  late Color primaryAlpha400 = const Color(0x673E8EFF);
  late Color greenAlpha50 = const Color(0xFF00C67F);
  late Color customColor38 = const Color(0xFFE5E5E5);
  late Color customColor39 = const Color(0xFFFFFFFF);
  late Color customColor40 = const Color(0xFFF0F8FF);
  late Color customColor41 = const Color(0xFF1C1C1C);
  late Color customColor42 = const Color(0xFFFFFFFF);
  late Color customColor43 = const Color(0xFF7F7F7F);
  late Color customColor44 = const Color(0xFF009FF5);
  late Color customColor45 = const Color(0xFFD9F1FD);
  late Color customColor46 = const Color(0xFF53BDF5);
  late Color customColor47 = const Color(0xFF0083C9);
  late Color customColor48 = const Color(0xFFAAB9C5);
  late Color customColor49 = const Color(0xFFE7EBEF);
  late Color customColor50 = const Color(0xFFC2CDD6);
  late Color customColor51 = const Color(0xFF92A5B5);
  late Color primary400 = const Color(0xFF0053C8);
  late Color primary500 = const Color(0xFF9FC7FF);
  late Color primaryAlpha500 = const Color(0x7F3E8EFF);
  late Color secondaryAlpha40 = const Color(0x65C4C4C4);
  late Color neutral200 = const Color(0xFFE2DEDE);
  late Color neutral300 = const Color(0xFFC8BABA);
  late Color neutral400 = const Color(0xFFB39293);
  late Color neutral500 = const Color(0xFFA06669);
  late Color nonSelection = const Color(0xFF82474C);
  late Color neutral700 = const Color(0xFF5F2D34);
  late Color neutral800 = const Color(0xFF381820);
  late Color neutralAlpha10 = const Color(0x190D1B2A);
  late Color neutral1000 = const Color(0xFF0D1B2A);
  late Color neutralAlpha20 = const Color(0x320D1B2A);
  late Color neutralAlpha30 = const Color(0x4D0D1B2A);
  late Color red100 = const Color(0xFFFB3748);
  late Color red200 = const Color(0xFFD00416);
  late Color redAlpha10 = const Color(0x1AFF4B4B);
  late Color red500 = const Color(0xFFFE0000);
  late Color red600 = const Color(0xFFB20000);
  late Color redAlpha25 = const Color(0x40FF4B4B);
  late Color redAlpha40 = const Color(0x65FF4B4B);
  late Color redAlpha50 = const Color(0x80FF4B4B);
  late Color yellow200 = const Color(0xFFDFB400);
  late Color customColor77 = const Color(0xFF7F7F7F);
  late Color customColor78 = const Color(0xFF000000);
  late Color primaryMainColor = const Color(0xFF3E7BFA);
  late Color navBg = const Color(0x99121417);
  late Color white = const Color(0xFFFFFFFF);
  late Color customColor79 = const Color(0xFFB189E6);
  late Color customColor1 = const Color(0xFFD011D3);
  late Color customColor2 = const Color(0xFF9E9C84);
  late Color customColor3 = const Color(0xFF667A76);
  late Color customColor4 = const Color(0xFF232158);
  late Color customColor5 = const Color(0xFF4E6057);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}
