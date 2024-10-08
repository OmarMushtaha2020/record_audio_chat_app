import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:record_audio_chat_app/data/model/record_model.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
import 'package:uuid/uuid.dart';

import 'event.dart';
import 'state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(InitialState());
  static ChatBloc get(context) => BlocProvider.of(context);
  RecordModel? recordModel;


  final record = AudioRecorder();
  bool is_record = false;
  String path = '';
  String url = '';
  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is StopVoiceRecord) {
      yield* _mapStopVoiceRecord();
    }
    if (event is PlayVoiceRecord) {
      yield* _mapPlayVoiceRecord(event.url??"");
    }
    if (event is ChangeValueIndex) {
      yield* _mapChangeValueOfIndex(event.value);
    }
    if(event is StartRecord){
      yield* _mapStartRecord();
    }
    if(event is StopRecord){
      yield* _mapStopRecord(event.senderId, event.receiverId, event.dateTime);

    }
    if(event is GetMessagesVoiceOfReceived){
      yield* _mapGetMessagesOfReceiver(event.id);

    }
    if(event is GetMessagesVoiceOfSender){
      yield* _mapGetMessagesOfSender(event.id);

    }

  }






  Future<void> addVoiceMessage(senderId,receiverId,dateTime,urlVoice) async {
    recordModel=RecordModel(senderId: senderId, receiverId: receiverId, dateTime: dateTime, urlVoice: urlVoice,isPlay:  false);
   await firestore.collection("user").doc(senderId)
        .collection("chats").doc(receiverId)
        .collection("messages_voice").add(recordModel!.toMap());

   await firestore.collection("user").doc(receiverId)
        .collection("chats").doc(senderId)
        .collection("messages_voice").add(recordModel!.toMap());
  }


  Future<void> uploadVoice(senderId,receiverId,dateTime) async {
    final ref = FirebaseStorage.instance.ref(
        "voice/${Uuid().v1()}"); // Use a unique ID

    try {
      await ref.putFile(File(path));
      url = await ref.getDownloadURL();

      // Ensure that Firestore operations are correct and handle them properly
   await   addVoiceMessage(senderId,receiverId,dateTime,url);

      print("upload");
      emit(UploadVoiceSucceed());
    } catch (onError) {
      emit(UploadVoiceFailed(onError.toString()));
    }
  }


  Stream<ChatState> _mapPlayVoiceRecord(String url) async* {

    try {
      playVoiceRecord(url);
      yield PlayVoiceRecordSucceed();
    } catch (error) {
      yield PlayVoiceRecordFailed(error.toString());
    }
  }
  Future<void> playVoiceRecord(String url) async {
    await audioPlayer?.play(UrlSource(url)).then((value) {
      is_player = true;
      print("audioPlayer");
      // emit(PlayVoiceRecordSucceed());
    });
      // emit(PlayVoiceRecordFailed(onError.toString()));
  }
  Stream<ChatState> _mapStopVoiceRecord() async* {

    try {
      stopVoiceRecord();
      yield  StopVoiceRecordSucceed();
    } catch (error) {
    }
  }
  Stream<ChatState> _mapChangeValueOfIndex(value) async* {
    changeValueOfIndex(value);
   yield ChangeValueOfIndex();
  }

  Future<void> changeValueOfIndex(value) async {
    indexValue=value;
    print("the index is$indexValue");
  }
  Future<void> stopVoiceRecord() async {

    await audioPlayer?.stop();
    is_player = false;
    print(is_player);
    print("stop audio");
    // emit(StopVoiceRecordSucceed());
  }
  Stream<ChatState> _mapStartRecord() async* {
    try{
   await   startRecord();

      yield StartRecordSucceed();
    }catch(error){
      yield StartRecordFailed(error.toString());

    }
  }
Future<void> startRecord() async {
  final location = await getApplicationDocumentsDirectory();
  String name = Uuid().v1();
  path =
  '${location.path}/$name.m4a'; // Added proper slash and file extension

  if (await record.hasPermission()) {
    await record.start(RecordConfig(), path: path).then((value) {
      is_record = true;
      print("start record");
      // emit(StartRecordSucceed());
    }).catchError((error) {
      // emit(StartRecordFailed(error.toString()));
    });
  }
}


  Stream<ChatState> _mapStopRecord(senderId, receiverId, dateTime) async* {
    try{
    await  stopRecord(senderId, receiverId, dateTime);

      yield StopRecordSucceed();
    }catch(error){
      yield StopRecordFailed(error.toString());

    }
  }


Future<void> stopRecord(senderId,receiverId,dateTime) async {
  await record.stop().then((value) async {
    is_record = false;
    print("stop record");

    // Verify if the file exists before uploading
    if (File(path).existsSync()) {
      await uploadVoice(senderId,receiverId,dateTime);
      // emit(StopRecordSucceed());
    } else {
      print("File does not exist at path: $path");
      // emit(StopRecordFailed("File not found"));
    }
  }).catchError((onError) {
    print(onError.toString());
    // emit(StopRecordFailed(onError.toString()));
  });
  // emit(StopRecordSucceed());
}

  Stream<ChatState> _mapGetMessagesOfSender( receiverId) async* {
 await   getMessagesOfSender(receiverId: receiverId);
    yield GetMessagesVoiceSenderSucceed();
  }
  Stream<ChatState> _mapGetMessagesOfReceiver( receiverId) async* {
  await  getMessagesOfReceiver(receiverId: receiverId);
    yield GetMessagesVoiceReceivedSucceed();
  }
Future<void> getMessagesOfSender({
  required String receiverId,
}) async {
  firestore
      .collection('user')
      .doc(userModel?.userUid)
      .collection('chats')
      .doc(receiverId)
      .collection('messages_voice')
      .orderBy('dateTime')
      .snapshots()
      .listen((event) {
    voice = [];

    event.docs.forEach((element) {
      voice.add(RecordModel.fromJson(element.data()));
      print("the length is ${voice.length}");
      emit(GetMessagesVoiceSenderSucceed());

    });

  });
}

Future<void> getMessagesOfReceiver({
  required String receiverId,
}) async{
  firestore
      .collection('user')
      .doc(receiverId)
      .collection('chats')
      .doc(userModel?.userUid)
      .collection('messages_voice')
      .orderBy('dateTime')
      .snapshots()
      .listen((event) {
    voice = [];

    event.docs.forEach((element) {
      voice.add(RecordModel.fromJson(element.data()));
      print("the length is ${voice.length}");
emit(GetMessagesVoiceReceivedSucceed());
    });

  });
}
}
