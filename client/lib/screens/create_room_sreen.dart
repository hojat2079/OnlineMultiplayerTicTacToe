import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resource/socket_method.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/screens/geme_screen.dart';
import 'package:tic_tac_toe/util/dimension.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/create-room';

  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethod _socketMethod = SocketMethod();

  @override
  void initState() {
    _socketMethod.createRoomSuccessListener((roomData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(roomData);
      Navigator.pushNamed(context, GameScreen.route);
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: SafeArea(
          child: Padding(
            padding: paddingH20,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Create Room',
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
                  SizedBox(
                    height: size.height * 0.045,
                  ),
                  CustomButton(
                      text: const Text('Create'),
                      onTap: () {
                        _socketMethod.createRoom(_nameController.text);
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
