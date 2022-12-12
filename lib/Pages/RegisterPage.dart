import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var fullname;
  var phone;
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
                  child :Form(
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Fullname',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: (firstname) {
                                  if (firstname!.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  fullname = firstname;
                                  return null;
                                },
                              ),
                              Divider(height: 10,),
                              TextFormField(

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: (emailValue) {
                                  if (emailValue!.isEmpty || !EmailValidator.validate(emailValue)) {
                                    return 'Please enter email';

                                  }
                                  email = emailValue;
                                  return null;
                                },
                              ),
                              Divider(height: 10,),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),

                                ),
                                validator: (phonenumber) {
                                  if (phonenumber!.isEmpty) {
                                    return 'Please enter phone number';

                                  }
                                  phone = phonenumber;
                                  return null;
                                },
                              ),
                              Divider(height: 10,),
                              TextFormField(
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
                                  password = passwordValue;
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
                            signUp();
                          }},
                        ),
                        const SizedBox(height: 30),




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
  Future signUp() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      print(e);
    }

    Navigator.of(context).popUntil((route) => route.isFirst);


  }
}
