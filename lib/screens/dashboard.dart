import 'package:Mugavan/screens/account.dart';
import 'package:Mugavan/screens/mypeople_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[MyPeopleList(), Account()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              label: "MyPeople",
              icon: Icon(Icons.list_alt),
              backgroundColor: Color.fromRGBO(31, 71, 136, 1)),
          BottomNavigationBarItem(
              label: "Account",
              icon: Icon(Icons.account_circle),
              backgroundColor: Color.fromRGBO(31, 71, 136, 1)),
        ],
        onTap: _onItemTap,
      ),
    );
  }
}
