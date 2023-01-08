import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifesaver_app/Widgets/DrawerWidget.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cnic_scanner/cnic_scanner.dart';

class IdVerificationPage extends StatefulWidget {
  const IdVerificationPage({Key? key}) : super(key: key);

  @override
  State<IdVerificationPage> createState() => _IdVerificationPageState();
}

class _IdVerificationPageState extends State<IdVerificationPage> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController nameTEController = TextEditingController(),
      cnicTEController = TextEditingController(),
      dobTEController = TextEditingController(),
      doiTEController = TextEditingController(),
      doeTEController = TextEditingController();
  CnicModel _cnicModel = CnicModel();
  Future<void> scanCnic(ImageSource imageSource) async {
    CnicModel cnicModel =
    await CnicScanner().scanImage(imageSource: imageSource);
    if (cnicModel == null) return;
    setState(() {
      _cnicModel = cnicModel;
      nameTEController.text = _cnicModel.cnicHolderName;
      cnicTEController.text = _cnicModel.cnicNumber;
      dobTEController.text = _cnicModel.cnicHolderDateOfBirth;
      doiTEController.text = _cnicModel.cnicIssueDate;
      doeTEController.text = _cnicModel.cnicExpiryDate;
    });
    print("cin : ${cnicTEController.text} , fullname ${nameTEController.text} ");

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "ID Card",
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
      drawer: DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Image.asset("assets/images/id_card.png"),

          ),

          Container(
            child: Column(
              children: [
                Text(
                  "Verify Your ID Card Now!",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    )

                  )
                ),
                SizedBox(height: 10,),
                Text(
                  "Make sure ! you capture the ID number.",
                  style: GoogleFonts.overpass(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,

                    )
                  ),
                ),
                SizedBox(height: 34,),
                ElevatedButton(
                    onPressed: (){
                      scanCnic(ImageSource.camera);
                    },
                    child: Text(
                      "Scan your ID",
                        style :  TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
