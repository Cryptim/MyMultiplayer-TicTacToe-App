import 'package:flutter/material.dart';
import 'package:tim_tictactoe/resource/socket_methods.dart';
import 'package:tim_tictactoe/responsive/responsive.dart';
import 'package:tim_tictactoe/widgets/custom_button.dart';
import 'package:tim_tictactoe/widgets/custom_text.dart';

import '../widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayersState(context);
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Responsive(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
                text: 'Join Room',
                fontsize: 70),
            SizedBox(
              height: size.height * 0.08,
            ),
            CustomTextField(
                controller: _nameController, hintText: 'Enter your nick name'),
            SizedBox(
              height: size.height * 0.045,
            ),
            CustomTextField(
                controller: _gameIdController, hintText: 'Enter Game ID'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Join',
              onTap: () => _socketMethods.joinRoom(
                _nameController.text,
                _gameIdController.text,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
