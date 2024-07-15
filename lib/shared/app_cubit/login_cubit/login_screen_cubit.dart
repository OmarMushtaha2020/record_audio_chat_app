import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_audio_chat_app/modules/user_screen/user_screen.dart';
import 'package:record_audio_chat_app/shared/app_cubit/login_cubit/login_screen_states.dart';
import 'package:record_audio_chat_app/shared/app_cubit/user_cubit/user_screen_cubit.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
import 'package:record_audio_chat_app/shared/network/local/cacth_helper.dart';

class LoginScreenCubit extends Cubit<LoginScreenStates> {
  LoginScreenCubit() : super(InitialState());

  static LoginScreenCubit get(context) => BlocProvider.of(context);

  int index = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn(String emailAddress,String password,context)async{
    emit(LoginLoad());
    final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    ).then((value) {
     Cacth_Helper.saveToken("token", value.user!.uid);
     token=value.user!.uid;
     UserScreenCubit.get(context).getUserData();
     emit(SignInSucceed());
      navigatorToScreen(context, '/user_screen');


    }).catchError((onError){
      emit(SignInFailed(onError.toString()));

      print(onError.toString());
    });
  }
}
