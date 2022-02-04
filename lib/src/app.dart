// import 'package:delivery_application/routes/router.gr.dart';
import 'package:delivery_application/src/providers/auth.dart';
import 'package:delivery_application/src/screens/dashboard/dashboard_screen.dart';
import 'package:delivery_application/src/screens/login/login_screen.dart';
import 'package:delivery_application/src/screens/store/add_to_cart_screen.dart';
import 'package:delivery_application/src/screens/store/store_screen.dart';
import 'package:delivery_application/src/screens/registration/registration_screen.dart';
import 'package:delivery_application/src/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            switch (settings.name) {
              case '/':
                return LoginScreen(context);
              case '/dashboard':
                return route(context, const DashboardScreen());
              case '/registration':
                return RegistrationScreen(context);
              case '/search':
                return route(context, SearchScreen(context, true));
              case '/productDetail':
                return route(context, StoreScreen(item: settings.arguments));
              case '/addToCart':
                return route(
                    context, AddToCartScreen(item: settings.arguments));
              default:
                return LoginScreen(context);
            }
          });
        },
      ),
    );
  }

  dynamic route(BuildContext context, dynamic screen) {
    final auth = Provider.of<Auth>(context, listen: false);
    return auth.isAuth ? const DashboardScreen() : LoginScreen(context);
  }
}
