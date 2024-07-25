abstract class ChatEvent {}

class InitEvent extends ChatEvent {}
class AddVoiceMessages extends ChatEvent{}
class StartRecord extends ChatEvent{}
class StopRecord extends ChatEvent{
  String? senderId;
  String?receiverId;
  String? dateTime;
  StopRecord(this.senderId,this.receiverId,this.dateTime);
}

class UploadVoice extends ChatEvent{}
class PlayVoiceRecord extends ChatEvent{
  String ?url;
  PlayVoiceRecord(this.url);
}
class StopVoiceRecord extends ChatEvent{}
class GetMessagesVoiceOfReceived extends ChatEvent{
  String ?id;
  GetMessagesVoiceOfReceived(this.id);
}
class GetMessagesVoiceOfSender extends ChatEvent{
  String ?id;
  GetMessagesVoiceOfSender(this.id);
}
class ChangeValueIndex extends ChatEvent{
  int ?value;
  ChangeValueIndex(this.value);

}
