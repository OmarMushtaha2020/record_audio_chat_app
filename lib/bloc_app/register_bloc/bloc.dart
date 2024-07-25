import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_audio_chat_app/bloc_app/user_bloc/bloc.dart';
import 'package:record_audio_chat_app/bloc_app/user_bloc/event.dart';
import 'package:record_audio_chat_app/data/model/user_model.dart';
import 'package:record_audio_chat_app/shared/app_cubit/user_cubit/user_screen_cubit.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
import 'package:record_audio_chat_app/shared/network/local/cacth_helper.dart';

import 'event.dart';
import 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitialState());

  static RegisterBloc get(context) => BlocProvider.of(context);
  int index = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController userName = TextEditingController();
  UserModel? userModel;
  TextEditingController passwordController = TextEditingController();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is CrateAccountEvent) {
      yield* _mapSignUp(event.name ?? "", event.email ?? "", event.phone ?? "",
          event.context, event.password);
    }
  }

  Stream<RegisterState> _mapSignUp(
      String name, String email, String phone, context, password) async* {
    try {
      createUserAccount(name, email, phone, context, password);
      yield RegisterSucceed();
    } catch (error) {
      yield RegisterFailed(error.toString());
    }
  }

  Future<void> createUserAccount(
      String name, String email, String phone, context, password) async {
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("the token is${value.user?.uid}");

      userModel = UserModel(
          name: name,
          email: email,
          phoneNumber: phone,
          userUid: "",
          token: value.user?.uid);
      Cacth_Helper.saveToken("token", value.user!.uid);
      token = value.user!.uid;
      firestore.collection("user").add(userModel!.toMap()).then((value) {
        print(value.id);
        firestore
            .collection("user")
            .doc("${value.id}")
            .update({"userUid": value.id}).then((value) {

          UserBloc.get(context).add(GetUserData());
          navigatorToScreen(context, '/user_screen');
        });
      });
    });
  }
}
