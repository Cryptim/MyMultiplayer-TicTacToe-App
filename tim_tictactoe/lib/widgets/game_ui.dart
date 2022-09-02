import 'package:flutter/material.dart';
import 'package:tim_tictactoe/provider/room_data_provider.dart';

class GameUi extends StatelessWidget {
  const GameUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                roomDataProvider.Player1.nickname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                roomDataProvider.Player1.points.toInt.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Nickname player 2"),
              Text("points player 2"),
            ],
          ),
        )
      ],
    );
  }
}
