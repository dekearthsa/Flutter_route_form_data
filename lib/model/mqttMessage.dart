class MassageModel {
  String senderType;
  String message;

  MassageModel({required this.senderType,required this.message });
  
  static MassageModel fromJson(json) => MassageModel(
    senderType: json['senderType'],
    message: json['message']
  );
}

