import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/bigtext.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

class otpPage extends StatefulWidget {
  const otpPage({super.key});

  @override
  State<otpPage> createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {
  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
        final p = Provider.of<myProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: null,
        backgroundColor: constraints.colorWhite,
        title: smalltext(
          text: "Verify your account",
          weight: FontWeight.bold,
          family: "Lato",
          size: 20,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        children: [
          mediumtext(text: "Enter the OTP we have sent to your email account",family: "Lato",),
          SizedBox(height: 30,),
          OTPTextField(
              controller: otpController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: constraints().getDeviceWidth(context) / 8,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onChanged: (pin) {
                debugPrint("Changed: " + pin);
              },
              onCompleted: (pin) {
                debugPrint("Completed: " + pin);
              }),
              SizedBox(height: 30,),
            TextButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                primary: constraints.secondaryColor
              ),
              onPressed: (){
                p.verifyOTP();
            }, child: smalltext(text: "Send",color: constraints.colorWhite,))
        ],
      ),
    );
  }
}
