import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/service/authRepositry.dart';

final authController = Provider((ref) {
  final auth = ref.watch(authRepositry);
  return AuthController(authRepositry: auth);
});

class AuthController {
  final AuthRepositry authRepositry;

  AuthController({required this.authRepositry});
  void getPhoneNumber(
      {required BuildContext context, required String phoneNumber}) async {
    authRepositry.signInWithPhone(context, phoneNumber);
  }

  void verifyOtp(
      {required BuildContext context,
      required verificationId,
      required userOtp}) async {
    authRepositry.verifyOtp(
        context: context, verificatinId: verificationId, userOtp: userOtp);
  }
}
