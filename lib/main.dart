import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woostorestackflutter/pages/DiscoveryPage.dart';
import 'package:woostorestackflutter/pages/SplachPage.dart';
import 'package:woostorestackflutter/services/ContractFactoryServies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractFactoryServies>(create: (context)=>ContractFactoryServies(),
      child: MaterialApp(
      title: 'Woo STore Dapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplachPage(),
    ),);
  }
}


