import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/Comman/pickFile.dart';
import 'package:whatsapp_complete/Comman/utils/colors.dart';
import 'package:whatsapp_complete/screens/bottomNavigator.dart';
import 'package:whatsapp_complete/service/authRepositry.dart';
import 'package:whatsapp_complete/services/authService.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  List<File> images = [];
  void sendUserdata(
      {required String name,
      required String bio,
      required String phoneNumber}) async {
    final errorM = await ref.watch(authServiceProvider).setUserDetail(
        context: context,
        name: name,
        bio: bio,
        photoUrl: images[0],
        phoneNumber: phoneNumber);
    if (errorM.error == null) {
      ref.watch(userProvider.notifier).update((state) => errorM.data);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => bottomNav()));
    } else {
      showSnackBar(errorM.error.toString(), context);
    }
  }

  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController bioContoller = TextEditingController();
  final TextEditingController PhoneContoller = TextEditingController();

  void pickImagesFile() async {
    var res = await pickImages(context: context);
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImagesFile();
                  },
                  child: CircleAvatar(
                    child: images.isNotEmpty
                        ? Image.file(images[0])
                        : Image.asset("assets/images/img1.png"),
                    radius: 100,
                  ),
                ),
                TextFormField(
                  controller: nameContoller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: PhoneContoller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Phone Number",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bioContoller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Write a Bio...",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    sendUserdata(
                        name: nameContoller.text.trim(),
                        bio: bioContoller.text,
                        phoneNumber: PhoneContoller.text);
                  },
                  child: Text("Upload"),
                  style: ElevatedButton.styleFrom(backgroundColor: tabColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
