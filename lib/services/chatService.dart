import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/Comman/errorHandilng.dart';
import 'package:whatsapp_complete/Comman/errorModel.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_complete/Comman/pickFile.dart';
import 'package:whatsapp_complete/Models/ChatInfo.dart';
import 'package:whatsapp_complete/Models/MessageModel.dart';
import 'package:whatsapp_complete/Models/chatModule.dart';
import 'package:whatsapp_complete/Models/reciverModel.dart';
import 'package:whatsapp_complete/Models/userModel.dart';
import 'package:whatsapp_complete/service/authRepositry.dart';

final chatServiceProvider = Provider((ref) => ChatService());

class ChatService {
  Future<ErrorModel> checkOUserLogin(
      {required BuildContext context,
      required String phoneNumber,
      required String token}) async {
    ErrorModel errorModel =
        ErrorModel(error: "Something Went Wrong", data: null);
    try {
      http.Response res = await http.get(
          Uri.parse('$ip/api/checkUser?phoneNumber=$phoneNumber'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token-w': token,
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            print(res.body);

            Map<String, dynamic> jsonMap =
                json.decode(res.body)[0]; // Assuming there is only one user
            ReciverUser user = ReciverUser.fromJson(jsonMap);

            // Now 'user' is a ReciverUser object containing the converted data.
            print(user.name); // Output: Parul Saini

            errorModel = ErrorModel(error: null, data: user);
          });
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }

  Future<ErrorModel> sendMessage(
      {required String message,
      required String reciverId,
      required String time,
      required BuildContext context,
      required String token}) async {
    ErrorModel errorModel =
        ErrorModel(error: "Something Went Wrong", data: null);
    try {
      ChatModule chatModule =
          ChatModule(message: message, reciverId: reciverId, time: time);

      http.Response res = await http.post(Uri.parse('$ip/api/message'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token-w': token,
          },
          body: chatModule.toJson());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            MessageModel messageModel =
                MessageModel.fromJson(jsonDecode(res.body));
            print(messageModel.phoneNumber);

            errorModel = ErrorModel(error: null, data: messageModel);
          });
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }

  Future<ChatInfo> getListOfChat(
      {required String token,
      required String phoneNumber,
      required BuildContext context}) async {
    List<ChatInfo> chatInfoList = [];
    http.Response res = await http.get(
        Uri.parse('$ip/api/listChat?phoneNumber=$phoneNumber'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token-w': token,
        });
    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          List<Map<String, dynamic>> jsonDataList =
              List<Map<String, dynamic>>.from(json.decode(res.body));

          chatInfoList =
              jsonDataList.map((json) => ChatInfo.fromJson(json)).toList();
          // errorModel = ErrorModel(error: null, data: chatInfoList);
        });

    return chatInfoList[0];
  }
}
