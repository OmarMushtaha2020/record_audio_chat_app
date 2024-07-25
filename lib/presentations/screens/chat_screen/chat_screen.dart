import 'package:audioplayers/audioplayers.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:record_audio_chat_app/bloc_app/chat_bloc/bloc.dart';
import 'package:record_audio_chat_app/bloc_app/chat_bloc/event.dart';
import 'package:record_audio_chat_app/bloc_app/chat_bloc/state.dart';


import 'package:record_audio_chat_app/shared/components/constant/constant.dart';

class ChatScreen extends StatefulWidget {


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Duration duration = new Duration();
  Duration position = new Duration();


  @override
  void initState() {
    audioPlayer = AudioPlayer();
    super.initState();

    audioPlayer?.onDurationChanged.listen((Duration d) {
      print("objects");
      setState(() {
        duration = d;
        // isLoading = false;
      });
    });
    audioPlayer?.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
    audioPlayer?.onPlayerComplete.listen((event) {
      setState(() {
        // isPlaying = false;

        duration = new Duration();
        position = new Duration();
         is_player = false;

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer?.dispose();
  }

  @override
  Widget build(BuildContext context) {return BlocProvider(

      create: (context) => ChatBloc(),
      child: Builder(builder: (context) {
         uidOfUser=ModalRoute.of(context)?.settings.arguments.toString() ;
print("uidOfUser :$uidOfUser");
         userModel?.userUid==uidOfUser?     ChatBloc.get(context).add(GetMessagesVoiceOfSender( uidOfUser!)):
         ChatBloc.get(context).add(GetMessagesVoiceOfReceived( uidOfUser!));

        return BlocConsumer<ChatBloc, ChatState>(

          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var bloc = ChatBloc.get(context);

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      navigatorToScreen(context, '/user_screen');
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
              body: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BubbleNormalAudio(
                      isSender: voice[index].senderId == userModel!.userUid
                          ? true
                          : false,
                      delivered: true,

                      tail: true,
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 15.sp),
                      color: voice[index].senderId == userModel!.userUid
                          ? Colors.black
                          : Colors.blue,
                      isLoading: false,

                      isPlaying: indexValue == index?is_player:false,
                      duration: indexValue == index
                          ? duration.inSeconds.toDouble()
                          : 0,
                      position: indexValue == index
                          ? position.inSeconds.toDouble()
                          : 0,

                      onSeekChanged: (double value) {},
                      onPlayPauseButtonClick: () {
                        ChatBloc.get(context).add(ChangeValueIndex(index));
if(is_player==false){
  ChatBloc.get(context).add(PlayVoiceRecord(voice[index].urlVoice));
  setState(() {
    is_player=true;
  });
}else{
  print("omar");
  ChatBloc.get(context).add(StopVoiceRecord());

      setState(() {
        is_player=false;

      });

}


                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: voice.length),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print(bloc.is_record);
                  if (bloc.is_record == false) {
                    ChatBloc.get(context).add(StartRecord());

                  } else {
                    var now = DateTime.now();
                    String formattedDate =
                        DateFormat.MMMEd().add_jm().format(now);
                    ChatBloc.get(context).add(StopRecord(userModel?.userUid, uidOfUser,
                        formattedDate.toString()));

                   
                  }
                },
                child: bloc.is_record
                    ? const Icon(Icons.stop)
                    : const Icon(Icons.mic),
              ),
            );
          },
        );
      }),
    );
  }
}
