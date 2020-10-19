import 'package:e_card/pages/AddCard/add_card_page.dart';
import 'package:e_card/pages/Code/code_page.dart';
import 'package:e_card/pages/Home/home_page.dart';
import 'package:e_card/providers/business_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    HomePage.routeName: (context) => HomePage(),
    AddCardPage.routeName: (context) => AddCardPage(),
    CodePage.routeName: (context) => CodePage()
  };

  final appTheme = ThemeData(
    primaryColor: Color(0xFFF50057),
    accentColor: Color(0xFF455A64),
    backgroundColor: Colors.grey[100],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => Color(0xFFF50057),
        ),
      ),
    ),
  );

  final providers = <SingleChildWidget>[
    ChangeNotifierProvider(create: (context) => BusinessCardProvider())
  ];

  Routes() {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(
      MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Card',
          theme: appTheme,
          initialRoute: HomePage.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
