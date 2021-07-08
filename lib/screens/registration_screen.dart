import 'package:flutter/material.dart';
import '../components/personalized_button.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  // const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                labelText: 'Enter a email',
                hintText: 'Enter a email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                labelText: 'Enter a password',
                hintText: 'Enter a password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            PersonalizedButton(
              title: 'Register',
              onPress: () {},
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
