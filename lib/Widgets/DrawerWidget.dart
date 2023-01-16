import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifesaver_app/Pages/HomePage.dart';
import 'package:lifesaver_app/Pages/IdVerificationPage.dart';
import 'package:lifesaver_app/Pages/IdicationsSecoursPage.dart';
import 'package:lifesaver_app/Pages/LoginPage.dart';
import 'package:lifesaver_app/Pages/ProfilePage.dart';
import 'package:lifesaver_app/Widgets/ListInddicationsWidget.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration:BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.2),
                  Theme.of(context).accentColor.withOpacity(0.5),
                ]
            )
        ) ,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text("LifeSaver APP",
                  style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),


            ListTile(
              leading: Icon(FontAwesomeIcons.homeUser, size: _drawerIconSize,color: Theme.of(context).accentColor),
              title: Text('Home Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
              },
            ),
            Divider(color: Theme.of(context).primaryColor, height: 1,),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.user, size: _drawerIconSize,color: Theme.of(context).accentColor),
              title: Text('Profil',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()),);
              },
            ),

            ListTile(
              leading: FaIcon(FontAwesomeIcons.idCard, size: _drawerIconSize,color: Theme.of(context).accentColor),
              title: Text('Vérifier votre Identité',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
                Navigator.push( context, MaterialPageRoute(builder: (context) => IdVerificationPage()),);
              },
            ),
            Divider(color: Theme.of(context).primaryColor, height: 1,),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.notesMedical, size: _drawerIconSize,color: Theme.of(context).accentColor),
              title: Text('Indications de secours',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
                Navigator.push( context, MaterialPageRoute(builder: (context) => IndicationsSecoursPage()),);
              },
            ),
            Divider(color: Theme.of(context).primaryColor, height: 1,),
            ListTile(
              leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
              title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
                _signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
