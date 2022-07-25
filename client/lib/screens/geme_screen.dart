import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resource/socket_method.dart';
import 'package:tic_tac_toe/screens/main_menu_screen.dart';
import 'package:tic_tac_toe/widgets/scoreboard.dart';
import 'package:tic_tac_toe/widgets/tictactoe_widget.dart';
import 'package:tic_tac_toe/widgets/waiting_widget.dart';

class GameScreen extends StatefulWidget {
  static const String route = '/game';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethod _socketMethod = SocketMethod();

  @override
  void initState() {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    _socketMethod.updatePlayerListener((players) {
      roomDataProvider
        ..updatePlayer1(players[0])
        ..updatePlayer2(players[1]);
    });
    _socketMethod.updateRoomListener((room) {
      roomDataProvider.updateRoomData(room);
    });
    _socketMethod.increasePointsPlayerListener((player) {
      if (player['socketID'] == roomDataProvider.p1.socketId) {
        roomDataProvider.updatePlayer1(player);
      } else {
        roomDataProvider.updatePlayer2(player);
      }
    });
    _socketMethod.endGameListener((player) {
      if (player['socketID'] == roomDataProvider.p1.socketId) {
        showDialogView(
            context, '${roomDataProvider.p1.nickName} Won the Game!');
      } else {
        showDialogView(
            context, '${roomDataProvider.p2.nickName} Won the Game!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: roomDataProvider.roomData['isJoin']
            ? const Center(
                child: WaitingWidget(),
              )
            : Column(
                children: [
                  const ScoreBoardWidget(),
                  const TicTacToeBoardWidget(),
                  Text(
                    '${roomDataProvider.roomData['turn']['nickName'].toString()}\'s turn',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void showDialogView(BuildContext context, String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Play Again'),
              )
            ],
          );
        });
  }
}
