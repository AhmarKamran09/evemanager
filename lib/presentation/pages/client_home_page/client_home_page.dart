import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/widgets/client_home_page/chat_view.dart';
import 'package:flutter/material.dart';

import '../../widgets/client_home_page/explore_view.dart';
import '../../widgets/client_home_page/home_view.dart';
import '../../widgets/client_home_page/planning_view.dart';
import '../../widgets/client_home_page/vendor_view.dart';

class ClientHomePage extends StatefulWidget {
  final String? uid;

  ClientHomePage({super.key, required this.uid});
  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeView(),
      VendorView(
        uid: widget.uid!,
      ),
      PlanningView(),
      ExploreView(),
      ChatView(
        userid: widget.uid!,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, PageNames.ProfileMenuPage,
                    arguments: widget.uid);
              },
              icon: Icon(size: 40, Icons.person)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // contains the track to compelte a booking
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'Vendors',
            // all the vendors types
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Planning',
            //budget  and asks the user to complete what services he need in checklist
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
            // recommendationsfor event (any type)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Messages',
            // all the vendors types
          ),
        ],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
