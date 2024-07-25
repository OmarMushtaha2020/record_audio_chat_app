import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_audio_chat_app/bloc_app/user_bloc/bloc.dart';
import 'package:record_audio_chat_app/bloc_app/user_bloc/event.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
import 'package:record_audio_chat_app/shared/network/local/cacth_helper.dart';

import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignInEvent) {
      yield* _mapSignIn(
          event.emailAddress ?? "", event.password ?? "", event.context);
    }
  }

  static LoginBloc get(context) => BlocProvider.of(context);

  int index = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Stream<LoginState> _mapSignIn(String emailAddress, String password, context) async* {
    yield LoginLoad();

    try {
      await signIn(emailAddress, password, context);
      yield SignInSucceed();
    } catch (error) {
      yield SignInFailed(error.toString());
    }
  }


  Future<void> signIn(String emailAddress, String password, context) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    ).then((value) {
      Cacth_Helper.saveToken("token", value.user!.uid);
      token = value.user!.uid;
      UserBloc.get(context).add(GetUserData());
      navigatorToScreen(context, '/user_screen');

    });
  }
}