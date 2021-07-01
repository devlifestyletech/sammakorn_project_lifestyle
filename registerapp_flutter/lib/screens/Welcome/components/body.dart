import 'package:flutter/material.dart';
import 'package:registerapp_flutter/components/rounded_button.dart';
import 'package:registerapp_flutter/screens/Login/login_screen.dart';
import 'package:registerapp_flutter/screens/Register/register_screen.dart';
import 'backgroud.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Backgroud(
      child: SingleChildScrollView(
        child: Column(
          children: [
            RoundedButton(
              text: "Login",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              topSize: 30,
            ),
            RoundedButton(
              text: "Register",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen();
                    },
                  ),
                );
              },
              topSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}
