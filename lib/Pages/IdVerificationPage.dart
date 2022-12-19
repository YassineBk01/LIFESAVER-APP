import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IdVerificationPage extends StatefulWidget {
  const IdVerificationPage({Key? key}) : super(key: key);

  @override
  State<IdVerificationPage> createState() => _IdVerificationPageState();
}

class _IdVerificationPageState extends State<IdVerificationPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final userAllInfo = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
