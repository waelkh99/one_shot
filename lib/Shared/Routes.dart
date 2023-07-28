import 'package:flutter/cupertino.dart';
import 'package:one_shot/Screens/HomeScreen/HomeScreen.dart';
import 'package:one_shot/Screens/SignupScreen/SignupScreen.dart';

import '../Screens/LoginScreen/LoginScreen.dart';

final Map<String, WidgetBuilder> routes = {
  SignupScreen.routeName: (context) => const SignupScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  // Profile.routeName: (context) => const Profile()
};