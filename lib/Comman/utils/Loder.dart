import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoderScreen extends ConsumerStatefulWidget {
  LoderScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoderScreen();
  }
}

class _LoderScreen extends ConsumerState<LoderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
