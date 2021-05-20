import 'package:fashion/screens/screens.dart';
import 'package:fashion/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const Scaffold(),
            settings: const RouteSettings(name: '/'));
      case SplashScreen.routeName:
        return SplashScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case NavScreen.routeName:
        return NavScreen.route();
      case Category.routeName:
        return Category.route();
      case '/testing':
        return MaterialPageRoute(
            builder: (_) => WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                    appBar: AppBar(),
                    drawer: NavigationDrawer(),
                    body: Center(
                      child: Text('testing'),
                    ),
                  ),
                ),
            settings: const RouteSettings(name: '/testing'));
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Center(
                child: Text('Something went wrong!'),
              ),
            ));
  }
}
