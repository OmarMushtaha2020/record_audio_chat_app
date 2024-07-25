// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:record_audio_chat_app/data/model/user_model.dart';
// import 'package:record_audio_chat_app/shared/app_cubit/user_cubit/user_screen_states.dart';
// import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
//
// class UserScreenCubit extends Cubit<UserScreenStates> {
//   UserScreenCubit() : super(InitialState());
//   static UserScreenCubit get(context) => BlocProvider.of(context);
//   int index = 0;
//   List<UserModel> users=[];
//   Future<void> getAllUser() async {
//     users=[];
//     firestore.collection("user").where("token",isNotEqualTo: token).get().then((value) {
//       value.docs.forEach((element) {
//         users.add(UserModel.fromJson(element.data()));
//         emit(GetAllUserSucceed());
//       });
//     }).catchError((error){
//       emit(GetAllUserFailed(error.toString()));
//     });
//   }
//   Future<void> getUserData() async {
//     if(token!=""){
//       firestore.collection("user")..where("token",isEqualTo: token).get().then((value) {
//  if(value.docs.isNotEmpty){
//    userModel = UserModel.fromJson(value.docs.first.data());
//    print(" name is /${userModel?.name}");
//    print(" email is /${userModel?.email}");
//    print(" email is /${userModel?.token}");
//    print(" email is /${userModel?.userUid}");
//
//    emit(GetUserDataSucceed());
//  }
//
//       }).catchError((error){
//         emit(GetUserDataFailed(error.toString()));
//       });
//     }
//
//   }
//
// }
