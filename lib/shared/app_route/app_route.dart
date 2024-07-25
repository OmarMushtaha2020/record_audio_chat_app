import 'package:flutter/material.dart';

import 'package:record_audio_chat_app/shared/components/constant/constant.dart';

import '../../presentations/screens/chat_screen/chat_screen.dart';
import '../../presentations/screens/login_screen/login_screen.dart';
import '../../presentations/screens/register_screen/register_screen.dart';
import '../../presentations/screens/user_screen/user_screen.dart';

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