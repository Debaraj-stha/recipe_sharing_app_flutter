import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/loginPage.dart';
import 'package:frontend/utils/bigtext.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../provider/myProvider.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<myProvider>(context, listen: false).initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<myProvider>(context, listen: false).dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    return Scaffold(
      body: Form(
        key: p.formKey,
        child: ListView(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: constraints().getDeviceHeight(context) / 7),
          children: [
            bigtext(
              text: "Sign up to Recipe Sharing App",
              color: constraints.primaryColor,
              family: "LobsterTwo",
            ),
            SizedBox(
              height: constraints().getDeviceHeight(context) / 16,
            ),
            inputField(p.nameController, p.nameNode, "Fullname", p),
            inputField(p.emailController, p.emailNode, "Email", p),
            inputField(p.passwordController, p.passwordNode, "Password", p),
            SizedBox(
              height: constraints().getDeviceHeight(context) / 20,
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: constraints.primaryColor),
                onPressed: () {
                  if (p.formKey.currentState!.validate()) {
                    p.signin();
                  } else {
                    debugPrint("invalid");
                  }
                },
                child: mediumtext(
                  text: "Sign Up",
                  family: "LobsterTwo ",
                  color: constraints.colorWhite,
                )),
            SizedBox(
              height: 10,
            ),
            Center(
                child: mediumtext(
              text: "OR",
            )),
            SizedBox(
              height: 5,
            ),
            SignInButton(Buttons.google, onPressed: () {}),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                smalltext(text: "Alreday have an account?"),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()));
                  },
                  child: Container(
                      child: mediumtext(
                    text: "Log In",
                    color: constraints.primaryColor,
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField(TextEditingController controller, FocusNode focusNode,
      String field, myProvider p) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: constraints.primaryColor, width: 2)),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              p.isinvalid = true;
              return "This field is required";
            } else if (field == "Password") {
              if (!p.passwordRegex.hasMatch(value)) {
                p.isinvalid = true;
                return "Invalid password field.Password should conatain capital,small letters,numeric value and special character";
              } else {
                debugPrint("valid");
                p.isinvalid = false;
                return null;
              }
            } else if (field == "Fullname") {
              if (!p.nameRegex.hasMatch(value)) {
                p.isinvalid = true;
                return "Invalid name field value.It must only contain characters";
              } else {
                p.isinvalid = false;
                debugPrint("valid");
                return null;
              }
            } else if (field == "Email") {
              if (!p.emailRegex.hasMatch(value)) {
                p.isinvalid = true;
                return "Invalid enail field value";
              } else {
                p.isinvalid = false;
                debugPrint("valid");
                return null;
              }
            } else {
              p.isinvalid = false;
              return null;
            }
          },
          controller: controller,
          focusNode: focusNode,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              hintText: field + "...",
              hintStyle: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
