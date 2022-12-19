import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifesaver_app/Pages/MedicalFormPage.dart';
import 'package:lifesaver_app/Pages/RegisterPage.dart';
import 'package:lifesaver_app/Utils.dart';


class LoginInterface extends StatefulWidget {
  const LoginInterface({Key? key}) : super(key: key);

  @override
  State<LoginInterface> createState() => _LoginInterfaceState();
}

class _LoginInterfaceState extends State<LoginInterface> {
  @override
  var error;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      key: Utils.messengerKey,

      body: Container(

        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade500,
                  Colors.blue.shade400,
                ]
            )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            // #login, #welcome
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                  Text("LifeSaver",style: TextStyle(color: Colors.white,fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("your safety is our priority!",style: TextStyle(color: Colors.white,fontSize: 20),),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
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
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [



                                Form(
                                    key: _formKey,
                                    child : Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: const[
                                                BoxShadow(
                                                    color: Color.fromRGBO(171, 171, 171, .7),blurRadius: 20,offset: Offset(0,10)),
                                              ],
                                            ),


                                            child: Column(
                                              children: [


                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                                  ),
                                                  child:  TextFormField(
                                                    decoration: InputDecoration(
                                                        hintText: "Email",
                                                        hintStyle: TextStyle(color: Colors.grey),
                                                        border: InputBorder.none
                                                    ),
                                                    validator: (emailValue) {
                                                      if (emailValue!.isEmpty || !EmailValidator.validate(emailValue)) {
                                                        return 'Please enter a valid email ';
                                                      }
                                                      email = emailValue;
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                                  ),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        hintText: "Password",
                                                        hintStyle: TextStyle(color: Colors.grey),
                                                        border: InputBorder.none
                                                    ),
                                                    validator: (passwordValue) {
                                                      if (passwordValue!.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      password = passwordValue;
                                                      return null;
                                                    },
                                                  ),
                                                ),

                                              ],
                                            )




                                        ),
                                        const SizedBox(height: 40),
                                        TextButton(
                                          onPressed: () {

                                            if (_formKey.currentState!.validate()) {
                                              signIn();

                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            margin: const EdgeInsets.symmetric(horizontal: 50),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Colors.blue[800]
                                            ),
                                            child: const Center(
                                              child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 17),),
                                            ),
                                          ),)

                                      ],
                                    )

                                ),

                                const SizedBox(height: 30),

                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => RegisterPage()));
                                  },
                                  child: Text(
                                    'Create new Account ?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ],
                      )
                    ),


              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e){

      print(e);
      setState(() {
        error=e.message;
      });
    }

    Navigator.of(context).popUntil((route) => route.isFirst);


  }


}
