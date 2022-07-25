import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resource/game_method.dart';
import 'package:tic_tac_toe/resource/socket_method.dart';
import 'package:tic_tac_toe/util/colors.dart';
import 'package:tic_tac_toe/util/dimension.dart';

class TicTacToeBoardWidget extends StatefulWidget {
  const TicTacToeBoardWidget({Key? key}) : super(key: key);

  @override
  State<TicTacToeBoardWidget> createState() => _TicTacToeBoardWidgetState();
}

class _TicTacToeBoardWidgetState extends State<TicTacToeBoardWidget> {
  final SocketMethod _socketMethod = SocketMethod();
  final GameMethod gameMethod = GameMethod();

  @override
  void initState() {
    super.initState();
    _socketMethod.tapListeners((data) {
      Provider.of<RoomDataProvider>(context, listen: false)
        ..updateRoomData(data['room'])
        ..updateDisplay(data['index'], data['choice']);
      gameMethod.checkWinner(_socketMethod.socketClient, context);
    });
  }

  void tap(int index, RoomDataProvider roomDataProvider) {
    _socketMethod.tapGrid(index, roomDataProvider.displayElement,
        roomDataProvider.roomData['_id']);
  }

  @override
  Widget build(BuildContext context) {
    final RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context);
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: _socketMethod.socketClient.id !=
            roomDataProvider.roomData['turn']['socketID'],
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => tap(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDataProvider.displayElement[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100,
                          shadows: [
                            BoxShadow(
                              color:
                                  roomDataProvider.displayElement[index] == 'O'
                                      ? Colors.red
                                      : Colors.blue,
                              blurRadius: textBlurShadowColor,
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
