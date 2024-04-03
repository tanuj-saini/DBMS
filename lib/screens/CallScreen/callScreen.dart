import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/screens/ChatScreen/chatScreen.dart';
import 'package:whatsapp_complete/screens/ChatScreen/usereChatScreen.dart';
import 'package:whatsapp_complete/screens/bottomNavigator.dart';
import 'package:whatsapp_complete/service/authRepositry.dart';
import 'package:whatsapp_complete/services/authService.dart';
import 'package:whatsapp_complete/services/chatService.dart';

class CallScreen extends ConsumerStatefulWidget {
  CallScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CallScreen();
  }
}

class _CallScreen extends ConsumerState<CallScreen> {
  void getCheckUser({required String phoneNumber}) async {
    final errorMod = await ref.watch(chatServiceProvider).checkOUserLogin(
        context: context,
        phoneNumber: phoneNumber,
        token: ref.read(userProvider)!.token ?? '');
    if (errorMod.error == null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => UserChatScreen(reciverUser: errorMod.data),
      ));
    } else {
      showSnackBar(errorMod.error.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            getCheckUser(phoneNumber: "8769163698");
          },
          child: ListTile(
            title: Text("8769163698"),
          ),
        ),
      ),
    );
  }
}
