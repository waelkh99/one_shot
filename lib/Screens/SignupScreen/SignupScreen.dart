import 'package:flutter/material.dart';
import 'package:one_shot/Screens/LoginScreen/LoginScreen.dart';
import 'package:one_shot/Shared/DBConnections.dart';
import '../../Shared/Responsive.dart';
import '../../Shared/SizeConfig.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = "/Signup";
  const SignupScreen({Key? key}) : super(key: key);
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
  TextEditingController confirmPasswordController = TextEditingController();

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
                  'Sign up',
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
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Confirm Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign up'),
                  onPressed: () async {
                    if (passwordController.text == confirmPasswordController.text) {
                        Future<String> signupResult = DBConnections.signup(nameController.text, passwordController.text);
                        if (await signupResult == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 5),
                                content: Text('User Created Successfully!'),
                              )
                          );
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text( await signupResult),
                              )
                          );
                        }
                      }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text('Passwords do not match'),
                          )
                      );
                      confirmPasswordController.clear();
                    }
                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                )
              ],
            ),
          ],
        ));
  }


}