import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forbes400_flutter/views/cat_list.dart';
import 'package:forbes400_flutter/views/real_time_net_worth.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return const MaterialApp(
      //theme: ThemeData(primarySwatch: Colors.blue),
        home: AppHomePage()
    );
  }
}


class AppHomePage extends StatefulWidget {
  const AppHomePage({Key? key}) : super(key: key);


  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          RealTimeNetWorth(),
          CategoriesNetWorth(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Real Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_style_outlined),
            label: 'Categories',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 30, 115, 190),
        onTap: _onItemTapped,
      ),
    );
  }
}
