
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shake/shake.dart';
import 'package:geolocator/geolocator.dart';

class BackgroundTask extends Service {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? _locationRef;






  void startListening() {
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      sendLocation("Call Ambulance");
    });
  }

  void sendLocation(String emergency) async {

    Position position = await Geolocator.getCurrentPosition();
    final user = await FirebaseAuth.instance.currentUser!;
    _locationRef = _firestore.collection('locations');
    if(user != null){
      _locationRef!.add({
        'user_id': user.uid,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': Timestamp.now(),
        'emergency': emergency,
      });
    }
  }






}
