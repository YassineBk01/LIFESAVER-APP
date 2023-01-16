import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifesaver_app/Models/UserApp.dart';
import 'package:lifesaver_app/Widgets/DrawerVerifWidget.dart';
import 'package:lifesaver_app/Widgets/DrawerWidget.dart';
import 'package:lifesaver_app/Widgets/ListInddicationsWidget.dart';


class IndicationsSecoursPage extends StatefulWidget {
  const IndicationsSecoursPage({Key? key}) : super(key: key);

  @override
  State<IndicationsSecoursPage> createState() => _IndicationsSecoursPageState();
}

class _IndicationsSecoursPageState extends State<IndicationsSecoursPage> {
  late UserApp currentUser = UserApp(id: "", fullname: "fullname", age: 21, cin: "cin", phone: "phone", email: "email", password: "password");

  void getUsersData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;

        currentUser = UserApp(id: data['id'], fullname: data['fullname'], age: data['age'], cin: data['cin'], phone: data['phone'], email: data['email'], password: data['password']);
        currentUser.hasMedicalFile=data['hasMedicalFile'];
        currentUser.profileImg = data['profileImg'];
        currentUser.isVerified = data['isVerified'];




      } else {
        print('Document does not exist on the database');
      }
    });
  }
  void initState() {

    super.initState();
    getUsersData();


  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text( "Indications De Secours",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: Colors.white,

          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu,color: Colors.white,size: 25,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: currentUser.isVerified ? DrawerVerifWidget() : DrawerWidget(),

      body: SingleChildScrollView(

        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30,left: 15),
                width: 300,
                padding: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(

                  border: Border(

                    bottom: BorderSide(
                      color: Color.fromARGB(255, 255, 179, 0),
                      width: 4,

                    ),


                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Indications de secours :", style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 6, 45, 108),
                    fontWeight: FontWeight.w900,

                  ), textAlign: TextAlign.center,),),),
              SizedBox(height: 20,),

              ListOfIndications(),

              Container(
                margin: EdgeInsets.only(top: 30,left: 15),
                width: 300,
                padding: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(

                  border: Border(

                    bottom: BorderSide(
                      color: Color.fromARGB(255, 255, 179, 0),
                      width: 4,

                    ),


                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Les numéros d'appel d'urgence :", style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 6, 45, 108),
                    fontWeight: FontWeight.w900,

                  ), textAlign: TextAlign.center,),),),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(


                  children: [
                    Row(
                      children: [
                        Text("Police :  ",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,color: Colors.blue))),
                        Text("190",style: GoogleFonts.dmSans(textStyle: TextStyle( fontSize: 18,)))
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("Ambulance / Pompiers :  ",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,color: Colors.blue))),
                        Text("150",style: GoogleFonts.dmSans(textStyle: TextStyle( fontSize: 18,)))
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      children: [
                        Text("Gendarmerie Royale :  ",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,color: Colors.blue))),
                        Text("177",style: GoogleFonts.dmSans(textStyle: TextStyle( fontSize: 18,)))
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("Centre Antipoison :   ",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,color: Colors.blue))),
                        Text("05 37 68 64 64 ",style: GoogleFonts.dmSans(textStyle: TextStyle( fontSize: 18,)))
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      children: [
                        Text("Lutte contre la corruption :  ",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,color: Colors.blue))),
                        Text("08 00 100 76 76",style: GoogleFonts.dmSans(textStyle: TextStyle( fontSize: 18,)))
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      children: [
                        Text("SOS discrimination raciale :  ",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,color: Colors.blue))),
                        Text("114",style: GoogleFonts.dmSans(textStyle: TextStyle( fontSize: 18,)))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),

            ],
          ),
        ),

      ),
    );
  }
}
