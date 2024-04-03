import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_complete/service/authRepositry.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(jsonDecode(response.body)["msg"], context);
      break;
    case 500:
      showSnackBar(jsonDecode(response.body)["error"], context);
      break;
    default:
      showSnackBar(response.body, context);
  }
}
