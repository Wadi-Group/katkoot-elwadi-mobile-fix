class SendMessageSuccessData {
  String? message;

  SendMessageSuccessData({
    this.message,
  });

  factory SendMessageSuccessData.fromJson(Map<String, dynamic> json) {
    return SendMessageSuccessData(
        message: json['msg'],
    );
  }
}
