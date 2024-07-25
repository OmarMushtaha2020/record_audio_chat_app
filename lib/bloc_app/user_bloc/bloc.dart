import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_audio_chat_app/data/model/user_model.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';

import 'event.dart';
import 'state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialState());
  static UserBloc get(context) => BlocProvider.of(context);
  int index = 0;
  List<UserModel> users=[];
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserData) {
      yield*  _mapGetUserData();
    }
    if (event is GetAllUser) {
      yield* _mapGetAllUser();
    }
  }


  Stream<UserState> _mapGetAllUser() async* {
    try{
    await  getAllUser();
      yield GetAllUserSucceed();
    }catch(error){
      yield GetAllUserFailed(error.toString());

    }
  
  }
  Stream<UserState> _mapGetUserData() async* {
    try{
      getUserData();
      yield GetUserDataSucceed();
    }catch(error){
      yield GetUserDataFailed(error.toString());

    }

  }

  Future<void> getAllUser() async {
    users=[];
  await  firestore.collection("user").where("token",isNotEqualTo: token).get().then((value) {
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
        print("users ${users.length}");
      });
    });
  }
  Future<void> getUserData() async {
    if(token!=""){
      firestore.collection("user")..where("token",isEqualTo: token).get().then((value) {
        if(value.docs.isNotEmpty){
          userModel = UserModel.fromJson(value.docs.first.data());
          print(" name is /${userModel?.name}");
          print(" email is /${userModel?.email}");
          print(" email is /${userModel?.token}");
          print(" email is /${userModel?.userUid}");

        }

      });
    }

  }

}
