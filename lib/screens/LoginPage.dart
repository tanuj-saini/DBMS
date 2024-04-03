import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/Comman/utils/colors.dart';
import 'package:whatsapp_complete/service/authController.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends ConsumerState<LoginScreen> {
  final TextEditingController phoneNumberContoller = TextEditingController();
  Country? country;
  String? statusCode;
  @override
  Widget build(BuildContext context) {
    void getPhoneNumber({required dynamic phoneNumber}) {
      ref
          .watch(authController)
          .getPhoneNumber(context: context, phoneNumber: "+91$phoneNumber");
      print("+91$phoneNumber");
    }

    void PickCountry() {
      showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
            statusCode = _country.phoneCode;
          });
        },
      );
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
              TextButton(
                  onPressed: () {
                    PickCountry();
                  },
                  child: Text("pickCountry")),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  if (country != null) Text("+$statusCode"),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneNumberContoller,
                      decoration: InputDecoration(
                        hintText: "EnterPhone Number",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    getPhoneNumber(phoneNumber: phoneNumberContoller.text);
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
