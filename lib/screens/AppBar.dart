import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer.dart';

class RoundAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  const RoundAppBar({Key? key, required this.pageTitle}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: 
        
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8,0,10,4),
                child: Text(                
                  pageTitle,
                  style: GoogleFonts.aleo(
                    textStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    
                  ),
                ),
              ),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          
          flexibleSpace: ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(218, 0, 228, 186),
                    Color.fromARGB(218, 0, 228, 186),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
