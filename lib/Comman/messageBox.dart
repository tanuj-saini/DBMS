import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/Comman/utils/colors.dart';

class messageBox extends ConsumerStatefulWidget {
  final String message;
  final bool isMe;
  messageBox({required this.isMe, required this.message, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _messageBox();
  }
}

class _messageBox extends ConsumerState<messageBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Center(child: Text(widget.message)),
          constraints: BoxConstraints.tightFor(height: 80),
          decoration: BoxDecoration(
              color: widget.isMe == true ? messageColor : senderMessageColor),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
