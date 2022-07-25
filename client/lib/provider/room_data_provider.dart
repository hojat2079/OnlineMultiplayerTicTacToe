import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  Map<String, dynamic> get roomData => _roomData;

  Player _p1 =
      Player(nickName: '', socketId: '', points: 0, type: PlayerType.x);
  Player _p2 =
      Player(nickName: '', socketId: '', points: 0, type: PlayerType.o);

  final List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];

  List<String> get displayElement => _displayElement;

  int _fillDisplayElementSize = 0;

  int get fillDisplayElementSize => _fillDisplayElementSize;

  Player get p1 => _p1;

  Player get p2 => _p2;

  void updateRoomData(Map<String, dynamic> newRoomData) {
    _roomData = newRoomData;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> json) {
    _p1 = Player.fromJson(json);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> json) {
    _p2 = Player.fromJson(json);
    notifyListeners();
  }

  void updateDisplay(int index, String choice) {
    _displayElement[index] = choice.toUpperCase();
    debugPrint('choice -> ${choice.toUpperCase()}');
    _fillDisplayElementSize++;
    notifyListeners();
  }

  void clearDisplayElement() {
    for (int i = 0; i < _displayElement.length; i++) {
      _displayElement[i] = '';
    }
    _fillDisplayElementSize = 0;
    notifyListeners();
  }
}
