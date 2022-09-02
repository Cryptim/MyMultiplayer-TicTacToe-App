import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_tictactoe/provider/room_data_provider.dart';
import 'package:tim_tictactoe/screens/create_room_screen.dart';
import 'package:tim_tictactoe/screens/game_screen.dart';
import 'package:tim_tictactoe/screens/join_room_screen.dart';
import 'package:tim_tictactoe/screens/main_menu_screen.dart';
import 'package:tim_tictactoe/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

//FutureBuilder:take a req ->send it http is like Future
//StreamBuilder:can take a req -> send it ->Listens to it and socketIo is like streams
//SnapShot ->stream ->socket Io 2way
//get ->Future->Http 1way
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
