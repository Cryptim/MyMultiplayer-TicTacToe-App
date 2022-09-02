import 'package:flutter/material.dart';
import 'package:tim_tictactoe/provider/room_data_provider.dart';
import 'package:tim_tictactoe/utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, SocketClient) {
    RoomDataProvider roomDataProvider =
        Provider<RoomDataProvider>(context, listen: false);
    String winner = ''; //x or 0;
    //check rows
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[2] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0]; //x or o

    }
    if (roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[1] != '') {
      winner = roomDataProvider.displayElements[1];
    }
    if (roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    } else if (roomDataProvider.filledBoxes == 9) {
      winner = '';
      showGameDialogue(context, 'Draw');
      //display game dialogue box saying draw
    }
    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner) {
        showGameDialogue(context, '${roomDataProvider.player1.nickname} won!');
        //display game dialogue box saying player 1 winner
        SocketClient.emit('winner', {
          'winnerSocketId': roomDataProvider,
          'roomId': roomDataProvider.roomData['_id'],
        });
      } else {
        //display game dialogue box saying player 2 winner
        showGameDialogue(context, '${roomDataProvider.player2.nickname} won!');
        SocketClient.emit('winner', {
          'winnerSocketId': roomDataProvider.player2.socketID,
          'roomId': roomDataProvider.roomData['_id'],
        });
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }
    roomDataProvider.setFilledBoxesTo0();
  }
}
