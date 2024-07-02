import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

/// Defines app theme including text themes.
class ApplicationTheme {
  static ThemeData getAppThemeData() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
        primarySwatch: primarySwatchColor,
        scaffoldBackgroundColor: backgroundColor,
        // colorScheme:_customColorScheme,
        iconTheme: const IconThemeData(color: iconColor),
        appBarTheme: const AppBarTheme(backgroundColor: backgroundColor),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryTextColor,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 5.0.sp : 25.sp,
            fontWeight: FontWeight.w800,
            color: primaryTextColor,
            fontFamily: 'Heebo',
          ),
          displayLarge: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 4.5.sp : 19.sp,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Heebo',
          ),
          displayMedium: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 4.0.sp : 14.sp,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Noto Sans',
          ),
          displaySmall: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 3.5.sp : 12.5.sp,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Noto Sans',
          ),
          headlineMedium: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 3.0.sp : 11.sp,
            fontWeight: FontWeight.w600,
            color: primaryTextColor,
            fontFamily: 'Noto Sans',
          ),
          headlineSmall: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 2.5.sp : 10.sp,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Noto Sans',
          ),
          titleLarge: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 2.0.sp : 9.sp,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Noto Sans',
          ),
          titleMedium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textInputTitleColor,
            fontFamily: 'Noto Sans',
          ),
          titleSmall: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: bodyTextColor,
            fontFamily: 'Noto Sans',
          ),
          bodyLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: bodyTextColor,
            fontFamily: 'Noto Sans',
          ),
          bodyMedium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Noto Sans',
          ),
          labelLarge: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
            fontFamily: 'Noto Sans',
          ),
        ),
      );
}
