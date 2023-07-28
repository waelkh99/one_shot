import 'package:flutter/material.dart';
import 'package:one_shot/Screens/HomeScreen/HomeScreen.dart';
import 'package:one_shot/Screens/SignupScreen/SignupScreen.dart';
import 'package:one_shot/Shared/DBConnections.dart';
import 'package:one_shot/Shared/Responsive.dart';
import 'package:one_shot/Shared/SizeConfig.dart';

void main() => runApp(const LoginScreen());

class LoginScreen extends StatelessWidget {
  static String routeName = "/Login";
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
        body: Center(child: MyStatefulWidget()),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double screenWidth = 0;
  double screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    if(Responsive.isDesktop(context)){
      screenWidth = SizeConfig.screenWidth / 3;
      screenHeight = SizeConfig.screenWidth / 2;
    }
    else{
      screenWidth = SizeConfig.screenWidth;
      screenHeight = SizeConfig.screenWidth;
    }
    return SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'One Shot',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    Future<String> signInResult = DBConnections.signIn(nameController.text, passwordController.text);
                    if (await signInResult == ""){
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text( await signInResult),
                          )
                      );
                    }
                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Do not have an account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                  },
                )
              ],
            ),
          ],
        ));
  }
}