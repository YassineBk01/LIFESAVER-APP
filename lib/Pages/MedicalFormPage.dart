import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicalFormPage extends StatefulWidget {
  const MedicalFormPage({Key? key}) : super(key: key);

  @override
  State<MedicalFormPage> createState() => _MedicalFormPageState();
}

class _MedicalFormPageState extends State<MedicalFormPage> {
  final user = FirebaseAuth.instance.currentUser!;
  var error;
  final _formKey = GlobalKey<FormState>();
  final ControllerName = TextEditingController();
  final ControllerPhone = TextEditingController();
  final ControllerCIN = TextEditingController();
  final ControllerEmail = TextEditingController();
  final ControllerPassword = TextEditingController();
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
                                      controller : ControllerName,
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
                                      controller : ControllerCIN,
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
                                      controller : ControllerPhone,
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
                                      controller : ControllerEmail,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'if you have an allergy describe it  ',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),

                                    ),
                                    Divider(height: 10,),

                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              /// Sign Up
                              MaterialButton(
                                shape: const StadiumBorder(),
                                minWidth: 230,
                                height: 45,
                                color: Colors.blue[800],
                                child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 17),textAlign: TextAlign.center,),
                                onPressed: (){if (_formKey.currentState!.validate()) {

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
}
