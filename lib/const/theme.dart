import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'consts.dart';

class Styles {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
      drawerTheme: DrawerThemeData(
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:
            isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
      ),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
      // primarySwatch:  Colors.amber,
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary:
                isDarkTheme ? Consts.darksecondaryColor : Consts.secondaryColor,
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        actionsIconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness:
              isDarkTheme ? Brightness.light : Brightness.dark,
          statusBarColor: isDarkTheme ? Colors.black : Colors.white,
        ),
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      // iconTheme: IconThemeData(
      //   color: isDarkTheme ? Colors.white : Colors.black,
      // ),
      cardTheme: CardTheme(
        color: isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
      ),

      // snackBarTheme: const SnackBarThemeData(
      //   backgroundColor: Colors.deepOrangeAccent,
      //   contentTextStyle: TextStyle(
      //     color: Colors.white,
      //   ),
      // ),
      // sliderTheme: SliderThemeData(
      //   activeTrackColor: Colors.deepOrangeAccent,
      //   inactiveTrackColor: Colors.deepOrangeAccent.withOpacity(0.5),
      //   thumbColor: Colors.deepOrangeAccent,
      // ),

      // navigationBarTheme: NavigationBarThemeData(
      //   backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      // ),

      // switchTheme: SwitchThemeData(
      //   thumbColor: MaterialStateProperty.resolveWith<Color?>(
      //       (Set<MaterialState> states) {
      //     if (states.contains(MaterialState.disabled)) {
      //       return null;
      //     }
      //     if (states.contains(MaterialState.selected)) {
      //       return Colors.deepOrangeAccent;
      //     }
      //     return null;
      //   }),
      //   trackColor: MaterialStateProperty.resolveWith<Color?>(
      //       (Set<MaterialState> states) {
      //     if (states.contains(MaterialState.disabled)) {
      //       return null;
      //     }
      //     if (states.contains(MaterialState.selected)) {
      //       return Colors.deepOrangeAccent;
      //     }
      //     return null;
      //   }),
      // ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor:
            isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
        selectionHandleColor:
            isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        // overlayColor: MaterialStateProperty.resolveWith<Color?>(
        //     (Set<MaterialState> states) {
        //   if (states.contains(MaterialState.disabled)) {
        //     return null;
        //   }
        //   if (states.contains(MaterialState.selected)) {
        //     return isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor;
        //   }

        //   return null;
        // }),
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor;
          }
          if (states.contains(MaterialState.selected)) {
            return isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor;
          }

          return null;
        }),
        // checkColor: MaterialStateProperty.resolveWith<Color?>(
        //     (Set<MaterialState> states) {
        //   if (states.contains(MaterialState.disabled)) {
        //     return null;
        //   }
        //   if (states.contains(MaterialState.selected)) {
        //     return Colors.deepOrangeAccent;
        //   }
        //   return null;
        // }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: isDarkTheme ? Colors.grey : Colors.grey,
          backgroundColor:
              isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:
              isDarkTheme ? Consts.darkprimaryColor : Consts.primaryColor,
        ),
      ),
      listTileTheme: ListTileThemeData(
        textColor: isDarkTheme ? Colors.white : Colors.white,
        iconColor: isDarkTheme ? Colors.white : Colors.white,
      ),

      // buttonColor:
      //     isDarkTheme ? const Color(0xffD5D5D5) : const Color(0xffD5D5D5),
      cardColor:
          isDarkTheme ? const Color(0xffb35a89) : const Color(0xffff80ab),
      // canvasColor:
      //     isDarkTheme ? const Color(0xff212121) : const Color(0xffE5E0E0),
      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //       buttonColor: isDarkTheme ? Colors.green : Colors.blue,
      //       colorScheme: isDarkTheme
      //           ? const ColorScheme.light()
      //           : const ColorScheme.dark(),
      //     ),
    );
  }
}
