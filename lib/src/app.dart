import 'package:delivery_application/src/screens/home/home_screen.dart';
import 'package:delivery_application/src/screens/login/login_screen.dart';
import 'package:delivery_application/src/screens/store/add_to_cart_screen.dart';
import 'package:delivery_application/src/screens/store/store_screen.dart';
import 'package:delivery_application/src/screens/registration/registration_screen.dart';
import 'package:delivery_application/src/screens/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: Colors.red[300],
        accentColor: Colors.cyan[300],
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return LoginScreen(context);
            case '/home':
              return MyHomeScreen();
            case '/registration':
              return RegistrationScreen(context);
            case '/search':
              return SearchScreen(context, true);
            case '/productDetail':
              return StoreScreen(item: settings.arguments);
            case '/addToCart':
              return AddToCartScreen(item: settings.arguments);
            default:
              return LoginScreen(context);
          }
        });
      },
    );
  }
}
