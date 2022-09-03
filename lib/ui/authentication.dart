import 'package:crash_course/net/flutterfire.dart';
import 'package:crash_course/ui/home.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'your email address',
                  hintStyle: TextStyle(color: Colors.black12),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'your password',
                  hintStyle: TextStyle(color: Colors.black12),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            Container(
              child: MaterialButton(
                onPressed: () async {
                  bool shallNavigate = await signIn(
                      emailController.text, passwordController.text);

                  if (shallNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }
                },
                child: const Text('Sign in'),
              ),
            ),
            Container(
              child: MaterialButton(
                onPressed: () async {
                  bool shallNavigate = await register(
                      emailController.text, passwordController.text);

                  if (shallNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }
                },
                child: const Text('Register'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
