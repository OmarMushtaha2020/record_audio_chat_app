class RecordModel{
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String urlVoice;
  late bool isPlay;


  RecordModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.urlVoice,
    required this.isPlay,

  });

  RecordModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    urlVoice = json['urlVoice'];
    isPlay=json['isPlay'];

  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'urlVoice': urlVoice,
      'isPlay':isPlay,
    };

  }
}