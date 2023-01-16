import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
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
  XFile? _imageFile;
  String _text = '';
  String cin="";
  bool isVerified=false;
  String message="";

  Future<void> getImageAndExtractText() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
        cin = data['cin'];
        print('cin : ${cin}');
      } else {
        print('Document does not exist on the database');
      }
    });
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = imageFile;
    });
    final inputImage = InputImage.fromFilePath(_imageFile!.path);

    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {

        setState(() {
          _text += line.text + " ";
        });


      }
    }
    isVerified = _text.contains(cin);
    print('isverif : ${_text.contains(cin)}');

    if(isVerified){
      message="Your Account is Verified Successfully!";
    }else{
      message="We Couldn't verify your account! Try Again!";
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(user.uid.toString()).update({'isVerified': isVerified }).then((value) => print("User Updated")).catchError((error) => print("Failed to update user: $error"));

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
                      setState(() {
                        _text='';
                      });
                        VerificationId();
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
                SizedBox(height: 25,),
                Text(message,
                style: GoogleFonts.overpass(
                  textStyle: TextStyle(
                    color: isVerified ? Colors.green:Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,

                  ),),
                ),
                Text(_text)
              ],
            ),
          )
        ],
      ),
    );
  }

 void VerificationId() async{
   showDialog(
       context: context,
       barrierDismissible: false,
       builder: (context) => Center(child: CircularProgressIndicator(),)
   );
    await getImageAndExtractText();

   Navigator.pop(context);
 }
}
