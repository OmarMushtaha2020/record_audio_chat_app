import 'dart:ui' as ui;

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:record_audio_chat_app/data/model/record_model.dart';
import 'package:record_audio_chat_app/data/model/user_model.dart';

final windowSize = ui.window.physicalSize;
final screenScale = ui.window.devicePixelRatio;
double screenWidth = windowSize.width / screenScale;
double screenHeight = windowSize.height / screenScale;
List<RecordModel> voice = [];
int indexValue=0;

String? Function(String?) validator(String titleOfError) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return "$titleOfError: It should not be empty";
    }
    return null;
  };
}
bool is_player = false;
String? uidOfUser;

void navigatorToScreen(context, String screenName,{String? value}) {
  Navigator.pushReplacementNamed(context, '$screenName',arguments: "w");
}
FirebaseFirestore firestore=FirebaseFirestore.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
String token='';
AudioPlayer ?audioPlayer;
UserModel ?userModel;
