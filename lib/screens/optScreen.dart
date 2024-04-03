import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/Comman/utils/colors.dart';
import 'package:whatsapp_complete/service/authController.dart';

class Otp extends ConsumerStatefulWidget {
  final String verificatinId;
  Otp({required this.verificatinId, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Otp();
  }
}

class _Otp extends ConsumerState<Otp> {
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void verifyOtp({required String userOtp}) {
      ref.watch(authController).verifyOtp(
          context: context,
          verificationId: widget.verificatinId,
          userOtp: userOtp);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Login with Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: otpController,
                decoration: InputDecoration(
                  hintText: "EnterOtp",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    verifyOtp(userOtp: otpController.text);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: tabColor),
                  child: Text("Done"))
            ],
          ),
        ),
      ),
    );
  }
}
