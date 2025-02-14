import 'package:flutter/material.dart';

import 'constants.dart';

final lightTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.grey.shade200,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade200,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      inversePrimary: Colors.grey.shade900,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        
        actionsIconTheme: IconThemeData(color: grey)),
        
      
    // Add other theme properties here...
    );

final darkTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade800,
      primary: Colors.grey.shade600,
      secondary: Colors.grey.shade800,
      inversePrimary: Colors.grey.shade300,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade800,
        surfaceTintColor: Colors.grey.shade800,
        actionsIconTheme: IconThemeData(color: grey))
    // Add other theme properties here...
    );
