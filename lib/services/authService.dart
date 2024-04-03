import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_complete/Comman/errorHandilng.dart';
import 'package:whatsapp_complete/Comman/errorModel.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_complete/Comman/pickFile.dart';
import 'package:whatsapp_complete/Models/userModel.dart';
import 'package:whatsapp_complete/screens/bottomNavigator.dart';
import 'package:whatsapp_complete/service/authRepositry.dart';

final authServiceProvider = Provider((ref) => AuthService());
final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthService {
  Future<ErrorModel> setUserDetail(
      {required BuildContext context,
      required String name,
      required String bio,
      required File photoUrl,
      required String phoneNumber}) async {
    ErrorModel errorModel = ErrorModel(error: null, data: null);
    try {
      String photoUrlCLo = '';
      final cloudinary = CloudinaryPublic("dix3jqg7w", 'aqox8ip4');
      CloudinaryResponse response = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(photoUrl.path, folder: bio));
      photoUrlCLo = response.secureUrl;

      UserModel userModel = UserModel(
          name: name,
          id: "",
          bio: bio,
          photoUrl: photoUrlCLo,
          token: "",
          chat: [],
          phoneNumber: phoneNumber);

      http.Response res = await http.post(Uri.parse("$ip/api/signIn"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: userModel.toJson());

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            // print(res.body);
            String token = jsonDecode(res.body)["token"];

            //print(token);
            UserModel user =
                UserModel.fromJson(jsonEncode(jsonDecode(res.body)));

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("x-auth-token-w", token);
            showSnackBar("send", context);

            errorModel = ErrorModel(error: null, data: user);
          });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    return errorModel;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel errorModel =
        ErrorModel(error: "Something Went Worng", data: null);
    try {
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token-w');
      if (token == null) {
        prefs.setString('x-auth-token-w', '');
      }
      print(token);
      var tokenRes = await http
          .post(Uri.parse('$ip/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token-w': token!,
      });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes =
            await http.get(Uri.parse('$ip/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token-w': token,
        });

        final userData =
            UserModel.fromJson(jsonEncode(jsonDecode(userRes.body)));
        print("welcome again");

        errorModel = ErrorModel(error: null, data: userData);
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }
}
