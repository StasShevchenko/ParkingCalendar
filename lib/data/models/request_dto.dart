class RequestDto {
  final int id;
  final bool isActive;
  final bool? result;
  final SenderReceiverInfo sender;
  final SenderReceiverInfo receiver;
  final DateTime sent;
  final SwapInfo swapInfo;

  RequestDto({
    required this.id,
    required this.isActive,
    this.result,
    required this.sender,
    required this.receiver,
    required this.sent,
    required this.swapInfo,
  });

  factory RequestDto.fromJson(Map<String, dynamic> json) {
    return RequestDto(
      id: json["id"],
      isActive: json["is_active"],
      result: json["result"],
      sender: SenderReceiverInfo.fromJson(json["sender"]),
      receiver: SenderReceiverInfo.fromJson(json["receiver"]),
      sent: DateTime.parse(json["sent"]),
      swapInfo: SwapInfo.fromJson(json["swap"]),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "sender": {
        "id": sender.id,
        "fullName": sender.fullName,
        "email": sender.email
      },
      "receiver":{
        "id": receiver.id,
        "fullName": receiver.fullName,
        "email": receiver.email
      },
      "sent": sent.toString(),
      "swap":{
        "from": swapInfo.from.toString(),
        "to": swapInfo.to.toString()
      }
    };
  }
}

class SenderReceiverInfo {
  final int id;
  final String fullName;
  final String email;

  SenderReceiverInfo(
      {required this.fullName, required this.email, required this.id});

  factory SenderReceiverInfo.fromJson(Map<String, dynamic> json) {
    return SenderReceiverInfo(
        fullName: json["fullName"], email: json["email"], id: json["id"]);
  }
}

class SwapInfo {
  final DateTime from;
  final DateTime to;

  SwapInfo({required this.from, required this.to});

  factory SwapInfo.fromJson(Map<String, dynamic> json) {
    return SwapInfo(
        from: DateTime.parse(json["from"]), to: DateTime.parse(json["to"]));
  }
}
