// import 'package:delivery_application/routes/router.gr.dart';
import 'dart:convert';

import 'package:delivery_application/models/arguments/item_argument.dart';
import 'package:delivery_application/models/arguments/menu_item_argument.dart';
import 'package:delivery_application/src/providers/auth.dart';
import 'package:delivery_application/src/screens/dashboard/dashboard_screen.dart';
import 'package:delivery_application/src/screens/login/login_screen.dart';
import 'package:delivery_application/src/screens/settings/edit_profile_screen.dart';
import 'package:delivery_application/src/screens/store/add_to_cart_screen.dart';
import 'package:delivery_application/src/screens/store/store_screen.dart';
import 'package:delivery_application/src/screens/registration/registration_screen.dart';
import 'package:delivery_application/src/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          primaryColor: Colors.red[300],
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            toolbarTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            final auth = Provider.of<Auth>(context, listen: false);
            if (auth.isAuth) {
              switch (settings.name) {
                case '/':
                  return LoginScreen(context);
                case '/dashboard':
                  return const DashboardScreen();
                case '/registration':
                  return RegistrationScreen(context);
                case '/search':
                  return SearchScreen(context, true);
                case '/productDetail':
                  final item = settings.arguments as ItemArgument;
                  return StoreScreen(item: item.value);
                case '/editProfile':
                  return EditProfileScreen(context);
                case '/addToCart':
                  final item = settings.arguments as MenuItemArgument;
                  return AddToCartScreen(item: item.value);
                default:
                  return LoginScreen(context);
              }
            } else {
              switch (settings.name) {
                case '/':
                  return LoginScreen(context);
                case '/registration':
                  return RegistrationScreen(context);
                default:
                  return LoginScreen(context);
              }
            }
          });
        },
      ),
    );
  }

  dynamic route(BuildContext context, StatefulWidget screen) {
    final auth = Provider.of<Auth>(context, listen: false);
    return auth.isAuth ? screen : LoginScreen(context);
  }
}
