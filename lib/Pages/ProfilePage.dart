import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifesaver_app/Models/UserApp.dart';
import 'package:lifesaver_app/Widgets/DrawerWidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserApp currentUser = UserApp(id: "", fullname: "fullname", age: 21, cin: "cin", phone: "phone", email: "email", password: "password");
  final user = FirebaseAuth.instance.currentUser!;

  String? pathProfileImmg;
  String? imagUrl;
  PickedFile? pickedFile;
  String? fileName;
  UploadTask? uploadTask;

  Future getUrl() async{

    if(currentUser.profileImg == "assets/images/profile.jpg" ){
      setState(() {
        pathProfileImmg = "assets/images/profile.jpg";
      });
    }
    else{

      final storageRef = FirebaseStorage.instance.ref();
      final url = await storageRef.child("imgFiles").getDownloadURL();
      setState(() {
        imagUrl = url;
      });

    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if(result ==null) return;

    setState(() {
      pickedFile =result.files.first as PickedFile?;
      fileName = result.files.first.name;
    });

  }

  Future uploadFile() async {
    final path ='imgFiles/${currentUser.id.toString()}/${fileName}';
    final file =File(pickedFile!.path);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot =  await uploadTask!.whenComplete(() {});

    await FirebaseFirestore.instance.collection("users").doc(currentUser.id.toString()).set({
      'profileImg': path,
    }).then((value) => print("Path modifié")).catchError((error) => print("Failed to modify path: $error"));

    setState(() {
      uploadTask =null;
    });
  }

  void getUsersData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
        setState(() {
          currentUser = UserApp(id: data['id'], fullname: data['fullname'], age: data['age'], cin: data['cin'], phone: data['phone'], email: data['email'], password: data['password']);
        });


      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void initState() {

    super.initState();
    getUsersData();
  }
  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "Profile",
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
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(

              child: Stack(

                children: [
                  CustomPaint(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
                    painter: HeaderCurvedContainer(),
                  ),

                  Center(
                    child: Column(

                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Hello "+currentUser.fullname,
                            style: TextStyle(
                              fontSize: 30,
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Container(

                          width: MediaQuery.of(context).size.width / 2.6,
                          height: MediaQuery.of(context).size.width / 2.6,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: (pickedFile == null) ? (imagUrl == null) ? Image.asset("assets/images/profile.jpg",fit: BoxFit.cover,) as DecorationImage? : Image.network(imagUrl!,fit: BoxFit.cover) as DecorationImage?
                            : Image.file(File(pickedFile!.path),fit: BoxFit.cover,) as DecorationImage?,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:160,left:255),
                    child: CircleAvatar(

                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          selectFile();
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 450,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textfield(
                        hintText: 'Fullname : '+currentUser.fullname,
                      ),
                      textfield(
                        hintText: 'Email : '+currentUser.email,
                      ),
                      textfield(
                        hintText: 'Phone : '+currentUser.phone,
                      ),
                      textfield(
                        hintText: 'CIN : '+currentUser.cin,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            uploadFile();
                          },
                          child: Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );

  }
  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask!.snapshotEvents,
      builder: (builder,snapshot){
          if (snapshot.hasData){
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100*progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],

              ),
            );
          }else{
            return const SizedBox(height: 50,);
          }
      }
  );
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF062D6C);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
