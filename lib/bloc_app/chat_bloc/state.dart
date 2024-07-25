abstract class ChatState {}

class InitialState extends ChatState {}


class  AddVoiceMessageSucceed   extends ChatState {}
class AddVoiceMessageFailed extends ChatState {
  final String error;

  AddVoiceMessageFailed(this.error);
}
class  StartRecordSucceed   extends ChatState {}
class StartRecordFailed extends ChatState {
  final String error;

  StartRecordFailed(this.error);
}

class  StopRecordSucceed   extends ChatState {}
class StopRecordFailed extends ChatState {
  final String error;

  StopRecordFailed(this.error);
}

class  UploadVoiceSucceed   extends ChatState {}
class UploadVoiceFailed extends ChatState {
  final String error;

  UploadVoiceFailed(this.error);
}
class  PlayVoiceRecordSucceed    extends ChatState {}
class PlayVoiceRecordFailed  extends ChatState {
  final String error;

  PlayVoiceRecordFailed(this.error);
}
class  StopVoiceRecordSucceed    extends ChatState {}
class StopVoiceRecordFailed extends ChatState {
  final String error;

  StopVoiceRecordFailed(this.error);
}

class  GetMessagesVoiceReceivedSucceed  extends ChatState {}
class  GetMessagesVoiceSenderSucceed  extends ChatState {}

class  ChangeValueOfIndex  extends ChatState {}

