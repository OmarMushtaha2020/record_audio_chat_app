import 'package:flutter/material.dart';

abstract class LoginEvent {}

class InitEvent extends LoginEvent {}
class SignInEvent extends LoginEvent{
  String ?emailAddress;
      String ?password;
  BuildContext?  context;
  SignInEvent(this.emailAddress,this.password,this.context);
}