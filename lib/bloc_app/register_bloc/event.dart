import 'dart:core';

import 'package:flutter/material.dart';

abstract class RegisterEvent {}

class InitEvent extends RegisterEvent {}
class CrateAccountEvent extends RegisterEvent {
  String ?name;
  String? email;
  String ?phone;
  BuildContext?  context;
  String ?password;
  CrateAccountEvent(this.name,this.email,this.phone,this.context,this.password);
}
