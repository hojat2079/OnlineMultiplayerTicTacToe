import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';

class GameMethod {
  void checkWinner(Socket socketClient, BuildContext context) {
    String winner = '';
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    //row
    if (roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[1] &&
        roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[2] &&
        roomDataProvider.displayElement[0].isNotEmpty) {
      winner = roomDataProvider.displayElement[0];
    } else if (roomDataProvider.displayElement[3] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[3] ==
            roomDataProvider.displayElement[5] &&
        roomDataProvider.displayElement[3].isNotEmpty) {
      winner = roomDataProvider.displayElement[3];
    } else if (roomDataProvider.displayElement[6] ==
            roomDataProvider.displayElement[7] &&
        roomDataProvider.displayElement[6] ==
            roomDataProvider.displayElement[8] &&
        roomDataProvider.displayElement[6].isNotEmpty) {
      winner = roomDataProvider.displayElement[6];
    }

    //column
    else if (roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[3] &&
        roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[6] &&
        roomDataProvider.displayElement[0].isNotEmpty) {
      winner = roomDataProvider.displayElement[0];
    } else if (roomDataProvider.displayElement[1] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[1] ==
            roomDataProvider.displayElement[7] &&
        roomDataProvider.displayElement[1].isNotEmpty) {
      winner = roomDataProvider.displayElement[1];
    } else if (roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[5] &&
        roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[8] &&
        roomDataProvider.displayElement[2].isNotEmpty) {
      winner = roomDataProvider.displayElement[2];
    }

    //diagonal
    else if (roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[8] &&
        roomDataProvider.displayElement[0].isNotEmpty) {
      winner = roomDataProvider.displayElement[0];
    } else if (roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[6] &&
        roomDataProvider.displayElement[2].isNotEmpty) {
      winner = roomDataProvider.displayElement[2];
    }
    if (winner.isEmpty && roomDataProvider.fillDisplayElementSize == 9) {
      showDialogView(context, 'Draw!');
      return;
    }

    if (winner.isNotEmpty) {
      if (winner == roomDataProvider.p1.type.name.toUpperCase()) {
        if (roomDataProvider.p1.points != 5) {
          showDialogView(context, '${roomDataProvider.p1.nickName} Won!');
        }
        socketClient.emit('winner', {
          'roomId': roomDataProvider.roomData['_id'],
          'socketID': roomDataProvider.p1.socketId
        });
      } else {
        if (roomDataProvider.p2.points != 5) {
          showDialogView(context, '${roomDataProvider.p2.nickName} Won!');
        }
        socketClient.emit('winner', {
          'roomId': roomDataProvider.roomData['_id'],
          'socketID': roomDataProvider.p2.socketId
        });
      }
      winner = '';
    }
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
                  clearScreen(context);
                  Navigator.pop(context);
                },
                child: const Text('Play Again'),
              )
            ],
          );
        });
  }

  void clearScreen(BuildContext context) {
    final RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    roomDataProvider.clearDisplayElement();
  }
}
