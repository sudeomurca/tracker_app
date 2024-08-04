import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
////example screen always vertical

import 'package:tracker_app/widgets/expenses.dart';

//theme works
var kColorScheme=ColorScheme.fromSeed(
  seedColor:const Color.fromARGB(255, 96, 59, 181),
  );

  var kDarkColorScheme=
  ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125),
  );

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();//locked orientation and make sure code ok
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,//up and vertical screen
  ]).then((fn){*/
 runApp(
    MaterialApp(
    
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,//default 
    //darkTheme controls
    darkTheme: ThemeData.dark().copyWith( 
  
  colorScheme: kDarkColorScheme,
  textTheme: const TextTheme(titleLarge: TextStyle(
    fontSize: 16,
  ),
  ),
  cardTheme:const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical:8,
           ),
  ),
  
   elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
           backgroundColor: kDarkColorScheme.primaryContainer, 
           foregroundColor: kDarkColorScheme.onPrimaryContainer
          ),
           ),
    ),
    //normal (light) theme 
    theme: ThemeData(
      useMaterial3: true,).copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme(
          backgroundColor:  Color.fromARGB(255, 174, 155, 246),
        foregroundColor:  Color.fromARGB(255, 250, 237, 253),
        ),
        cardTheme:const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical:8,
           ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
           backgroundColor: kColorScheme.primaryContainer, 
          ),
           ),
           textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16,),
           ),
        ),
       //main page widget
      home:const Expenses(),
      
    ),
  );
  //} ); 
}

