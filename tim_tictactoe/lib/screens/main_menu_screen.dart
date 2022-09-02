import 'package:flutter/material.dart';
import 'package:tim_tictactoe/responsive/responsive.dart';
import 'package:tim_tictactoe/screens/create_room_screen.dart';
import 'package:tim_tictactoe/screens/join_room_screen.dart';
import 'package:tim_tictactoe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);
  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(text: 'Create Room', onTap: () => createRoom(context)),
            const SizedBox(height: 20),
            CustomButton(
                text: 'Join Room',
                onTap: () {
                  joinRoom(context);
                })
          ],
        ),
      ),
    );
  }
}
