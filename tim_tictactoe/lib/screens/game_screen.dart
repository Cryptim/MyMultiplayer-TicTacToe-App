import 'package:flutter/material.dart';
import 'package:tim_tictactoe/provider/room_data_provider.dart';
import 'package:tim_tictactoe/resource/socket_methods.dart';
import 'package:tim_tictactoe/views/scoreboard.dart';
import 'package:tim_tictactoe/views/waiting_lobby.dart';
import 'package:tim_tictactoe/widgets/tictactoe_board.dart';

class GameScreen extends StatefulWidget {
  static String routeName = './game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersState(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
        body: roomDataProvider.roomData['isJoin']
            ? const WaitingLobby()
            : SafeArea(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBoard(),
                  TicTacToeBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['nickname']}\'s turn')
                ],
              )));
  }
}
