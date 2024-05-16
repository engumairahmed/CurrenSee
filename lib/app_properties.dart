import 'package:flutter/material.dart';

class ColorProperties {

  static Color darkColor = const Color(0xFF101820);
  static Color lightColor = const Color(0xFFF2AA4C);


  static Gradient purpleGradientColor = const LinearGradient(colors: [
    Color.fromARGB(255, 118, 51, 170),
    Color.fromARGB(255, 215, 15, 233),
  ]);
  
  static Gradient gradientcolor = const LinearGradient(colors: [
    Color.fromARGB(255, 153, 25, 50),
    Color.fromARGB(255, 47, 23, 55),
  ]);

    static Gradient yellowgradientcolor = const RadialGradient(colors: [
    Color(0xFFFFA426),
    Color(0xFFB26838),
    ]);

  static Gradient gradi = const LinearGradient(colors: [
    Color.fromARGB(255, 250, 130, 130),
    Color.fromARGB(255, 255, 255, 255),
  ]);

  static Gradient blueGreenColor = const LinearGradient(colors: [
    Color(0xFF00203F),
    Color(0xFFADEFD1),
  ]);

  static Color blueColor=const Color(0xFF00203F);

//Underwater
  static Gradient underwaterGradientColor = const LinearGradient(colors: [
    Color(0xFF195190),
    Color(0xFFA2A2A1),
  ]);

//CherryTomatoe & Black
static Gradient cherryTomatoeGradientColor = const LinearGradient(colors: [
    Color(0xFF2D2926),
    Color(0xFFE94B3C),
  ]);

  static Gradient blackGradientColor = const LinearGradient(colors: [
    Color(0xFF101820),
    Color(0xFFF2AA4C),
  ]);
 
 static Gradient mainColor =  const LinearGradient(
      colors: [    
        Color(0xFF00203F),
        Color(0xFFADEFD1),
      ]
  );

  static Gradient mainColorInverted =  const LinearGradient(
      colors: [    
        Color(0xFF00203F),
        Color(0xFFADEFD1),
      ]
  );
  static Gradient mainColorCross =  const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
      colors: [    
        Color(0xFF00203F),
        Color(0xFFADEFD1),
      ]
  );


  static Color purpleTextColor = const Color.fromARGB(255, 118, 51, 170);
  static Color maroonTextColor = const Color.fromARGB(255, 145, 11, 37);
  static Color firstColor =const Color.fromARGB(255, 47, 23, 55);
  static Color secondColor =const Color.fromARGB(255, 153, 25, 50);

}
