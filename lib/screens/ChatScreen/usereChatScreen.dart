import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:whatsapp_complete/Comman/messageBox.dart';
import 'package:whatsapp_complete/Comman/utils/Loder.dart';
import 'package:whatsapp_complete/Comman/utils/PhotoVeiw.dart';
import 'package:whatsapp_complete/Comman/utils/colors.dart';
import 'package:whatsapp_complete/Models/ChatInfo.dart';
import 'package:whatsapp_complete/Models/reciverModel.dart';
import 'package:whatsapp_complete/services/authService.dart';
import 'package:whatsapp_complete/services/chatService.dart';

class UserChatScreen extends ConsumerStatefulWidget {
  final ReciverUser reciverUser;
  UserChatScreen({required this.reciverUser, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UserChatScreen();
  }
}

class _UserChatScreen extends ConsumerState<UserChatScreen> {
  final TextEditingController mesaageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void sendMessage({
      required String message,
      required String reciverId,
      required String time,
    }) async {
      setState(() {
        mesaageController.text = '';
      });
      final errorM = await ref.watch(chatServiceProvider).sendMessage(
          message: message,
          reciverId: reciverId,
          time: time,
          context: context,
          token: ref.watch(userProvider)!.token ?? "");
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.abc))
            ],
            title: Row(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 45,
                    child: Image.network(widget.reciverUser.photoUrl ?? ''),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => PhotoZoom(
                          name: widget.reciverUser.name ?? '',
                          url: widget.reciverUser.photoUrl ?? ""))),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(widget.reciverUser.name ?? ""),
              ],
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: ref.watch(chatServiceProvider).getListOfChat(
                    token: ref.watch(userProvider)!.token ?? '',
                    phoneNumber: widget.reciverUser.phoneNumber ?? '',
                    context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoderScreen();
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: Text("Send a message..."),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.chatDetails!.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data!.reciverId !=
                          ref.watch(userProvider)!.id) {}
                      final lop = snapshot.data!.chatDetails![index].message;
                      return messageBox(
                          isMe:
                              snapshot.data!.chatDetails![index].itsMe ?? true,
                          message: lop ?? '');
                      // return Column(
                      //   children: [
                      //     ListTile(
                      //       title: Text(lop ?? ''),
                      //     ),
                      //   ],
                      // );
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              onFieldSubmitted: (value) {
                sendMessage(
                    message: mesaageController.text,
                    reciverId: widget.reciverUser.sId ?? "",
                    time: DateTime.now().toString());
              },
              controller: mesaageController,
              decoration: InputDecoration(
                  suffixIcon: FloatingActionButton(
                      backgroundColor: tabColor,
                      onPressed: () {
                        sendMessage(
                            message: mesaageController.text,
                            reciverId: widget.reciverUser.sId ?? "",
                            time: DateTime.now().toString());
                      },
                      child: Icon(Icons.send)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Type a message..."),
            ),
          )
        ],
      ),
    );
  }
}
