import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tim_tictactoe/widgets/custom_textfield.dart';

class WaitingLobby extends StatelessWidget {
  const WaitingLobby({Key? key}) : super(key: key);
  late TextEditingController roomIdController;
  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
    );
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Waiting for a User to Join"),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: roomIdController,
          hintText: '',
          isReadyOnly: true,
        )
      ],
    );
  }
}
