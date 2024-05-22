import 'package:currensee/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RoundAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final BuildContext buildContext;
  const RoundAppBar({Key? key, required this.pageTitle, required this.buildContext}) : super(key: key);

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
                padding: const EdgeInsets.fromLTRB(0,0,8,4),
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
                gradient: ColorProperties.mainColor
              ),
            ),
          ),
          leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: (){
            // globalKey.currentState!.openDrawer();
            Scaffold.of(buildContext).openDrawer();
            print('Button pressed');
          }
          ),
        ),
      ),
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
