import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/screens/HomeScreen.dart';
import 'package:whatsapp_complete/screens/optScreen.dart';

final authRepositry = Provider((ref) {
  return AuthRepositry(firebaseAuth: FirebaseAuth.instance);
});

class AuthRepositry {
  final FirebaseAuth firebaseAuth;

  AuthRepositry({required this.firebaseAuth});

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await firebaseAuth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: ((String verificationId, int? resendToken) async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => Otp(verificatinId: verificationId)));
          }),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificatinId,
      required String userOtp}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificatinId, smsCode: userOtp);
      await firebaseAuth.signInWithCredential(credential);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }
}

showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
