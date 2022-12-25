import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifesaver_app/Models/MedicalFile.dart';
import 'package:uuid/uuid.dart';

class MedicalFormPage extends StatefulWidget {
  const MedicalFormPage({Key? key}) : super(key: key);

  @override
  State<MedicalFormPage> createState() => _MedicalFormPageState();
}

class _MedicalFormPageState extends State<MedicalFormPage> {
  final user = FirebaseAuth.instance.currentUser!;
  var error;
  final _formKey = GlobalKey<FormState>();
  final ControllerHeight = TextEditingController();
  final ControllerAge = TextEditingController();
  final ControllerWeight = TextEditingController();
  final ControllerAllergy = TextEditingController();
  final ControllerBlood = TextEditingController();
  final ControllerDisease = TextEditingController();

  String Diabite = "Do you have Diabite";
  String heartDisease = "Do you have Heart Disease";
  String covidVaccine = "Are you vaccinated for covid19";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF062D6C),
                  Color(0xff0096ff),
                  Color(0xff4ec1f3),
                ]
            )
        ),
        child: Column(
          children: [
            /// Sign up & Welcome
            Container(
                padding: const EdgeInsets.only(top:80, bottom: 30, left: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Medical Form', style: TextStyle(color: Colors.white, fontSize: 40),),
                    SizedBox(height: 20),
                    Text('Life Saver App', style: TextStyle(color: Colors.white, fontSize: 18),),
                  ],
                )
            ),
            /// The rest
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
                  child : SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                            width:300,
                            child: error != null ?
                            Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.red,
                              child: Text(
                                error,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ):
                            null
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              /// Text Fields
                              Container(

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                          offset: const Offset(0, 10)
                                      )
                                    ]
                                ),
                                child: Column(
                                  children:  [
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller : ControllerHeight,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Height in cm',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      validator: (firstname) {
                                        if (firstname!.isEmpty) {
                                          return 'Please enter your Height';
                                        }

                                        return null;
                                      },
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller : ControllerWeight,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Weight in kg',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      validator: (cin) {
                                        if (cin!.isEmpty) {
                                          return 'Please enter your Weight';
                                        }

                                        return null;
                                      },
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller : ControllerAge,
                                      decoration: InputDecoration(

                                        border: InputBorder.none,
                                        hintText: 'Age',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),

                                      ),
                                      validator: (phonenumber) {

                                        if (phonenumber!.isEmpty) {
                                          return 'Please enter Age';
                                        }
                                        return null;
                                      },
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                     
                                      controller : ControllerBlood,
                                      decoration: InputDecoration(

                                        border: InputBorder.none,
                                        hintText: 'Group Blood ex: "O+,AB-,A+..."',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),

                                      ),
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      controller : ControllerAllergy,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'If you have an allergy describe it  ',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),

                                    ),
                                    Divider(height: 10,),
                                    DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Do you have diabite',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      value: Diabite,
                                      items: <String>["Do you have Diabite","Yes","No"].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: (Diabite == "Do you have Diabite") ? Text(
                                            value,
                                            style: TextStyle(fontSize: 16,color: Colors.black54),
                                          ) : Text(
                                            value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );}).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          Diabite = newValue!;
                                        });
                                      },
                                    ),
                                    Divider(height: 10,),
                                    DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Do you have Heart Didease',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      value: heartDisease,
                                      items: <String>["Do you have Heart Disease","Yes","No"].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: (heartDisease == "Do you have Heart Disease") ? Text(
                                            value,
                                            style: TextStyle(fontSize: 16,color: Colors.black54),
                                          ) : Text(
                                            value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );}).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          heartDisease = newValue!;
                                        });
                                      },
                                    ),
                                    Divider(height: 10,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                              ),
                                              value: "Are you vaccinated for covid19",
                                              items: <String>["Are you vaccinated for covid19","Yes","No"].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: (covidVaccine == "Are you vaccinated for covid19") ? Text(
                                                    value,
                                                    style: TextStyle(fontSize: 16,color: Colors.black54),
                                                  ) : Text(
                                                    value,
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                );}).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  covidVaccine = newValue!;
                                                });
                                              },
                                            ),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      controller : ControllerDisease,
                                      decoration: InputDecoration(

                                        border: InputBorder.none,
                                        hintText: 'If you had other Diseases indicate its',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),

                                      ),
                                    ),
                                  ],
                                ),
                              ),



                               SizedBox(height: 30),

                              MaterialButton(
                                shape: const StadiumBorder(),
                                minWidth: 230,
                                height: 45,
                                color: Colors.blue[800],
                                child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 17),textAlign: TextAlign.center,),
                                onPressed: (){if (_formKey.currentState!.validate()) {
                                       addMedicalForm();
                                }},
                              ),
                              const SizedBox(height: 30),




                            ],
                          ),
                        )
                      ],
                    ),

                  )

              ),
            ),
          ],
        ),
      ),
    );
  }
  Future addMedicalForm() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );
    try {

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      CollectionReference medicalFiles = FirebaseFirestore.instance.collection('medicalFiles');

      String idMedicalFile= Uuid().v4();
      MedicalFile medicalFile =MedicalFile(idMedicalFile, user.uid.toString(), ControllerHeight.text.trim(), ControllerWeight.text.trim(), int.parse(ControllerAge.text.trim()), ControllerAllergy.text.trim(), Diabite,heartDisease, ControllerBlood.text.trim(), covidVaccine, ControllerDisease.text.trim());
      final json = medicalFile.toJson();

      await medicalFiles.doc(idMedicalFile).set(json).then((value) => print("Medical File Added")).catchError((error) => print("Failed to add Medical File: $error"));

      await users.doc(user.uid.toString()).update({'hasMedicalFile': true ,'age': medicalFile.age }).then((value) => print("User Updated")).catchError((error) => print("Failed to update user: $error"));


    } on FirebaseAuthException catch (e){
      print(e);
      setState(() {
        error=e.message;
      });
    }


    Navigator.of(context).popUntil((route) => route.isFirst);


  }
}
