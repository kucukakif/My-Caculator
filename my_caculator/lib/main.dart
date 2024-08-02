import 'package:flutter/material.dart';
import 'package:my_caculator/screens/calculator_screen.dart';
import 'package:my_caculator/screens/rate_of_exchange_sceen.dart';
import 'package:my_caculator/service/rate_of_exchange.service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => RateOfExchangeProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, primary: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 17),
              indicatorColor: Colors.orange,
              dividerColor: Colors.black,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "Calculator",
                ),
                Tab(
                  text: "Rate of Exchange",
                )
              ],
            ),
          ),
          body: TabBarView(controller: _tabController, children: const [
            CalculatorScreen(),
            RateOfExchangeScreen(),
          ])),
    );
  }
}
