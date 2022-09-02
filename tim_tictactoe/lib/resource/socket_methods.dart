import 'package:flutter/material.dart';
import 'package:tim_tictactoe/resource/game_methods.dart';
import 'package:tim_tictactoe/screens/game_screen.dart';
import 'package:tim_tictactoe/utils/utils.dart';

import '../provider/room_data_provider.dart';
import 'socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;
  //Emits

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'round': roomId,
      });
    }
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, Listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccurredListener(BuildContext context) {
    _socketClient.on('erroeOccurred', (data) {
      showSnackBar(context, data);
    });
  }

//Listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
//check winner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePLayer2(playerData);
      }
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialogue(context, '${playerData['nickname']}won the game!');
      Navigator.pop(context, (route) => false);
    });
  }

  //Functions
  void updatePlayersState(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      playerData[0];
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[0]);
      playerData[1];
    });
  }
}
