import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store.dart';
import 'package:flutter_application_1/pages/cart_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';


void main() {
runApp(VxState(
  store: MyStore(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // 'key' is now a super parameter
    @override
    Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light, // for dark or default theme use Thememode.default
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        // primarySwatch: Colors.green,
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.homeRoute,
        routes: {
        "/": (context) => const LoginPage(),
        MyRoutes.homeRoute: (context) =>  HomePage(),
        MyRoutes.loginRoute: (context) =>  LoginPage(),
        MyRoutes.cartRoute: (context) =>  CartPage(),
        },
    );
    }
}
