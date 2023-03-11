import 'package:Mugavan/screens/account.dart';
import 'package:Mugavan/screens/my_voter_list.dart';
import 'package:Mugavan/utils/constant.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  late PageController pageController;

  final List<Widget> _widgetOptions = <Widget>[
    const MyVoterList(),
    // const AddVoter(),
    const Account(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              label: Constant.voter,
              icon: Icon(Icons.list_alt),
              backgroundColor: Color.fromRGBO(31, 71, 136, 1)),
          // BottomNavigationBarItem(
          //     label: 'இணை',
          //     icon: Icon(Icons.add_box_rounded),
          //     backgroundColor: Color.fromRGBO(31, 71, 136, 1)),
          BottomNavigationBarItem(
              label: Constant.account,
              icon: Icon(Icons.account_circle),
              backgroundColor: Color.fromRGBO(31, 71, 136, 1)),
        ],
        onTap: _onItemTap,
      ),
    );
  }
}
