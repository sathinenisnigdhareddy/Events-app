import 'package:provider/provider.dart';
import 'package:someapp/screens/dashpage.dart';
import 'package:someapp/screens/selectdash.dart';
import './screens/login_page.dart';
import 'package:flutter/material.dart';

import './providers/auth.dart';
import './providers/events.dart';
import './providers/showstat.dart';

void main() => runApp(MainApp());
 
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=>Auth()),
        ChangeNotifierProvider(create: (ctx)=>EventProvider()),
        ChangeNotifierProvider(create: (ctx)=>StatsProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home:Begin(),
        routes: {
          SelectDash.routeNamed:(ctx)=>SelectDash(),
          DashPage.routeName:(ctx)=>DashPage(),
          
        },
          ),
    );
  }
}