import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/screens/create_room_sreen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/util/dimension.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static const String routeName = '/main-menu';

  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Responsive(
          child: Padding(
            padding: paddingH8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: const Text('Create Room'),
                    onTap: () => createRoom(context),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    text: const Text('Join Room'),
                    onTap: () => joinRoom(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createRoom(BuildContext context) {
    Navigator.of(context).pushNamed(CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.of(context).pushNamed(JoinRoomScreen.routeName);
  }
}
