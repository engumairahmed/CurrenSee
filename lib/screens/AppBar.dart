import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer.dart';

class RoundAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RoundAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        'CurrenSee  Converter',
        style: GoogleFonts.aleo(
          textStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      
      centerTitle: true,
      flexibleSpace: Container(
        
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          gradient: LinearGradient(colors: [
            Color.fromARGB(218, 0, 228, 186),
         
            Color.fromARGB(218, 0, 228, 186),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
      ),
      drawer: CustomDrawer(),
    );

  }

}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CustomShape extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size) {
//     double height = size.height;
//     double width = size.width;

//     var path = Path();
//     path.lineTo(0, height-50);
//     path.quadraticBezierTo(width/2, height, width, height-50);
//     path.lineTo(width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }

// }



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 130,
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         flexibleSpace: ClipPath(
//           clipper: CustomShape(),
//           child: Container(
//             height: 250,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.red,
//             child: Center(
//               child: Text(
//                 "Subscribe to Proto Coders Point",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Container(),
//     );
//   }
// }
