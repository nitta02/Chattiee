import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        AnimatedPositioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            duration: const Duration(seconds: 1),
            child: Image.asset('assets/images/img1.png')),

        //google login button
        Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 223, 255, 187),
                    shape: const StadiumBorder(),
                    elevation: 1),
                onPressed: () {},

                //google icon
                icon: Icon(
                  Icons.network_cell,
                ),

                //login with google label
                label: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(text: 'Login with '),
                        TextSpan(
                            text: 'Google',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ]),
                ))),
      ],
    ));
  }
}
