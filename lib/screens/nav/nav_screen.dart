import 'package:fashion/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) =>
          //   BlocProvider<BottomNavBarCubit>(
          // create: (_) => BottomNavBarCubit(),
          // child:
          NavScreen(),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('title')),
        body: Center(child: Text('My Page!')),
        drawer: NavigationDrawer());
  }
}
