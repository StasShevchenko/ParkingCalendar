class RequestDto {
  final bool isActive;
  final bool? result;
  final SenderReceiverInfo sender;
  final SenderReceiverInfo receiver;
  final DateTime sent;
  final SwapInfo swapInfo;

  RequestDto({
    required this.isActive,
    required this.result,
    required this.sender,
    required this.receiver,
    required this.sent,
    required this.swapInfo,
  });

  factory RequestDto.fromJson(Map<String, dynamic> json) {
    return RequestDto(
      isActive: json["isActive"],
      result: json["result"],
      sender: SenderReceiverInfo.fromJson(json["sender"]),
      receiver: SenderReceiverInfo.fromJson(json["receiver"]),
      sent: DateTime.parse(json["sent"]),
      swapInfo: SwapInfo.fromJson(json["swap"]),
    );
  }
}

class SenderReceiverInfo {
  final String fullName;
  final String email;

  SenderReceiverInfo({required this.fullName, required this.email});

  factory SenderReceiverInfo.fromJson(Map<String, dynamic> json) {
    return SenderReceiverInfo(fullName: json["fullName"], email: json["email"]);
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
