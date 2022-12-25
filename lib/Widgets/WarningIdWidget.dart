import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifesaver_app/Pages/IdVerificationPage.dart';


class WarningIdWidget extends StatelessWidget {
  const WarningIdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Color.fromARGB(255, 232, 103, 17),
          margin: EdgeInsets.only(top: 15),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "You're enable to use LifeSaver services. Please verify your identity Card! ",
                  style: GoogleFonts.notoSans(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    primary: Color.fromARGB(255, 6, 45, 108),
                    onPrimary: Colors.white,
                    textStyle: GoogleFonts.atma(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IdVerificationPage()),);
                  },
                  label: Text(
                    "Id Card Verification",
                  ), icon: FaIcon(
                  FontAwesomeIcons.idCard,
                  color: Colors.white,
                ),


                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
