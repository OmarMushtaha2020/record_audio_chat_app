//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:record_audio_chat_app/data/model/user_model.dart';
// import 'package:record_audio_chat_app/shared/app_cubit/register_cubit/register_screen_states.dart';
// import 'package:record_audio_chat_app/shared/app_cubit/user_cubit/user_screen_cubit.dart';
// import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
// import 'package:record_audio_chat_app/shared/network/local/cacth_helper.dart';
//
// class RegisterScreenCubit extends Cubit<RegisterScreenStates> {
//   RegisterScreenCubit() : super(InitialState());
//
// //   static RegisterScreenCubit get(context) => BlocProvider.of(context);
// //   int index = 0;
// //   TextEditingController emailController = TextEditingController();
// //   TextEditingController phoneNumber = TextEditingController();
// //   TextEditingController userName = TextEditingController();
// //   UserModel ?userModel;
// //   TextEditingController passwordController = TextEditingController();
// //
// //   Future<void> createUserAccount(String name,String email,String phone,context,password) async {
// //   emit(RegisterLoad());
// //   firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
// //     print("the token is${value.user?.uid}");
// //
// //
// //     userModel =UserModel(name: name,email: email,phoneNumber: phone,userUid: "",token: value.user?.uid);
// //     Cacth_Helper.saveToken("token", value.user!.uid);
// //     token=value.user!.uid;
// //     firestore.collection("user").add(userModel!.toMap()).then((value) {
// //       print(value.id);
// //       firestore.collection("user").doc("${value.id}").update({"userUid":value.id}).then((value) {
// //         UserScreenCubit.get(context).getUserData();
// //         navigatorToScreen(context, '/user_screen');
// //
// //         emit(RegisterSucceed());
// //       });
// //     }).catchError((onError){
// //       print(onError.toString());
// //
// //       emit(RegisterFailed(onError.toString()));
// //     });
// //   }).catchError((onError){
// //     print(onError.toString());
// //   });
// //
// //
// //
// // }
// }
