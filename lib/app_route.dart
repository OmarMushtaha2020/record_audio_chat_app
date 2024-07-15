import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record_audio_chat_app/modules/chat_screen/chat_screen.dart';
import 'package:record_audio_chat_app/modules/login_screen/login_screen.dart';
import 'package:record_audio_chat_app/modules/register_screen/register_screen.dart';
import 'package:record_audio_chat_app/modules/user_screen/user_screen.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';

class AppRoute{
  Route?generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/login_screen":
        return  MaterialPageRoute(builder: (_)=>LoginScreen());
      case "/register_screen":
        return  MaterialPageRoute(builder: (_)=>RegisterScreen());
      case "/user_screen":
        return  MaterialPageRoute(builder: (_)=>UserScreen());
      case "/chat_screen":
        return  MaterialPageRoute(builder: (_)=>ChatScreen(),settings: RouteSettings(arguments: uidOfUser));
      default:
        return MaterialPageRoute(builder: (_)=> token==""?LoginScreen():UserScreen());
    }
  }
}