import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifesaver_app/Models/UserApp.dart';

import '';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final ControllerName = TextEditingController();
  final ControllerPhone = TextEditingController();
  final ControllerCIN = TextEditingController();
  final ControllerEmail = TextEditingController();
  final ControllerPassword = TextEditingController();
  var error;
  double _height=250;
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
                padding: const EdgeInsets.only(top:80, bottom: 30, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('LifeSaver', style: TextStyle(color: Colors.white, fontSize: 40),),
                    SizedBox(height: 10),
                    Text('Welcome', style: TextStyle(color: Colors.white, fontSize: 18),),
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
                        SizedBox(height: 20,),
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
                                      controller : ControllerName,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Fullname',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      validator: (firstname) {
                                        if (firstname!.isEmpty) {
                                          return 'Please enter your first name';
                                        }

                                        return null;
                                      },
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      controller : ControllerCIN,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'CIN',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      validator: (cin) {
                                        if (cin!.isEmpty) {
                                          return 'Please enter your CIN';
                                        }

                                        return null;
                                      },
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      controller : ControllerPhone,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Phone',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),

                                      ),
                                      validator: (phonenumber) {

                                        if (phonenumber!.isEmpty) {
                                          return 'Please enter phone number';

                                        }

                                        return null;
                                      },
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      controller : ControllerEmail,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Email',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      validator: (emailValue) {
                                        if (emailValue!.isEmpty || !EmailValidator.validate(emailValue)) {
                                          return 'Please enter email';

                                        }

                                        return null;
                                      },
                                    ),
                                    Divider(height: 10,),
                                    TextFormField(
                                      controller : ControllerPassword,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      validator: (passwordValue) {
                                        if (passwordValue!.isEmpty) {
                                          return 'Please enter some text';
                                        }

                                        return null;
                                      },
                                    ),
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
                                child: const Text('SignUp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 17),textAlign: TextAlign.center,),
                                onPressed: (){if (_formKey.currentState!.validate()) {
                                  final newUser =UserApp(id: "", fullname: ControllerName.text, age: 21, cin: ControllerCIN.text, phone: ControllerPhone.text, email: ControllerPhone.text, password: ControllerPassword.text);
                                  signUp(newUser);
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
  Future signUp(UserApp newUser) async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );
    try {
      UserCredential userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: ControllerEmail.text.trim(), password: ControllerPassword.text.trim());
      newUser.id = userCredential.user!.uid.toString();
      final json = newUser.toJson();
      await FirebaseFirestore.instance.collection("users").doc(newUser.id).set(json);

    } on FirebaseAuthException catch (e){
      print(e);
      setState(() {
        error=e.message;
      });
    }


    Navigator.of(context).popUntil((route) => route.isFirst);


  }
}
