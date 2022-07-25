import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/resource/socket_method.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/screens/geme_screen.dart';
import 'package:tic_tac_toe/util/dimension.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

import '../provider/room_data_provider.dart';

class JoinRoomScreen extends StatefulWidget {
  static const String routeName = '/join-room';

  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomIdController = TextEditingController();
  final SocketMethod _socketMethod = SocketMethod();

  @override
  void dispose() {
    _nameController.dispose();
    _roomIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _socketMethod.joinRoomSuccessListener(
      (data) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(data);
        Navigator.of(context).pushNamed(GameScreen.route);
      },
    );
    _socketMethod.errorOccurredListener(
      (data) => {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data.toString())))
      },
    );
    _socketMethod.updatePlayerListener((players) {
      Provider.of<RoomDataProvider>(context, listen: false)
        ..updatePlayer1(players[0])
        ..updatePlayer2(players[1]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Responsive(
          child: Padding(
            padding: paddingH20,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Join Room',
                    fontSize: shadowTextFontSize,
                    shadows: [
                      BoxShadow(
                        color: Colors.blue,
                        blurRadius: textBlurShadowColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  CustomTextField(
                    hint: 'Enter your nickname',
                    controller: _nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hint: 'Enter Game ID',
                    controller: _roomIdController,
                  ),
                  SizedBox(
                    height: size.height * 0.045,
                  ),
                  CustomButton(
                      text: const Text('Join'),
                      onTap: () {
                        _socketMethod.joinRoom(
                          _nameController.text,
                          _roomIdController.text,
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
