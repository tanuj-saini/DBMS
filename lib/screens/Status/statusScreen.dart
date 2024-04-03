import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusScreen extends ConsumerStatefulWidget {
  StatusScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _StatusScreen();
  }
}

class _StatusScreen extends ConsumerState<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
