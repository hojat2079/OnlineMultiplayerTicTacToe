class Player {
  final String nickName;
  final String socketId;
  final int points;
  final PlayerType type;

  Player({
    required this.nickName,
    required this.socketId,
    required this.points,
    required this.type,
  });

  Player.fromJson(Map<String, dynamic> json)
      : nickName = json['nickName'],
        socketId = json['socketID'],
        points = json['points'],
        type = json['playerType'] == 'x' ? PlayerType.x : PlayerType.o;

  Map<String, dynamic> toJson() {
    return {
      'nickName': nickName,
      'socketID': socketId,
      'points': points,
      'playerType': type == PlayerType.x ? 'x' : 'o'
    };
  }
}

enum PlayerType { x, o }
