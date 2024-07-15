import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:record_audio_chat_app/model/record_model.dart';
import 'package:record_audio_chat_app/shared/app_cubit/chat_cubit/chat_screen_states.dart';
import 'package:record_audio_chat_app/shared/components/constant/constant.dart';
import 'package:uuid/uuid.dart';

class ChatScreenCubit extends Cubit<ChatScreenStates> {
  ChatScreenCubit() : super(InitialState());

  static ChatScreenCubit get(context) => BlocProvider.of(context);

  RecordModel? recordModel;


  final record = AudioRecorder();
  bool is_record = false;
  String path = '';
  String url = '';
Future<void> changeValueOfIndex(value) async {
  indexValue=value;
  print("the index is$indexValue");
  emit(ChangeValueOfIndex());
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
        emit(StartRecordSucceed());
      }).catchError((error) {
        emit(StartRecordFailed(error.toString()));
      });
      emit(StartRecordSucceed());
    }
  }

  Future<void> stopRecord(senderId,receiverId,dateTime) async {
    await record.stop().then((value) async {
      is_record = false;
      print("stop record");

      // Verify if the file exists before uploading
      if (File(path).existsSync()) {
        await uploadVoice(senderId,receiverId,dateTime);
        emit(StopRecordSucceed());
      } else {
        print("File does not exist at path: $path");
        emit(StopRecordFailed("File not found"));
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(StopRecordFailed(onError.toString()));
    });
    emit(StopRecordSucceed());
  }
Future<void> addVoiceMessage(senderId,receiverId,dateTime,urlVoice) async {
    recordModel=RecordModel(senderId: senderId, receiverId: receiverId, dateTime: dateTime, urlVoice: urlVoice,isPlay:  false);
  firestore.collection("user").doc(senderId)
      .collection("chats").doc(receiverId)
      .collection("messages_voice").add(recordModel!.toMap());

  firestore.collection("user").doc(receiverId)
      .collection("chats").doc(senderId)
      .collection("messages_voice").add(recordModel!.toMap());
}
  void getMessagesOfSender({
    required String receiverId,
  }) {
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
      });

      emit(GetMessagesVoiceSucceed());
    });
  }
  void getMessagesOfReceiver({
    required String receiverId,
  }) {
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
      });

      emit(GetMessagesVoiceSucceed());
    });
  }
  Future<void> uploadVoice(senderId,receiverId,dateTime) async {
    final ref = FirebaseStorage.instance.ref(
        "voice/${Uuid().v1()}"); // Use a unique ID

    try {
      await ref.putFile(File(path));
      url = await ref.getDownloadURL();

      // Ensure that Firestore operations are correct and handle them properly
      addVoiceMessage(senderId,receiverId,dateTime,url);

      print("upload");
      emit(UploadVoiceSucceed());
    } catch (onError) {
      emit(UploadVoiceFailed(onError.toString()));
    }
  }

  Future<void> playVoiceRecord(String url) async {
    await audioPlayer?.play(UrlSource(url)).then((value) {
      is_player = true;
      print("audioPlayer");
      emit(PlayVoiceRecordSucceed());
    }).catchError((onError) {
      emit(PlayVoiceRecordFailed(onError.toString()));
    });
  }

  Future<void> stopVoiceRecord() async {

    await audioPlayer?.stop();
    is_player = false;
    print(is_player);
    print("stop audio");
    emit(StopVoiceRecordSucceed());
  }
}
