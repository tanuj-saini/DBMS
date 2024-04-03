import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  ChatScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatScreen();
  }
}

class _ChatScreen extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
