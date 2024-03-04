import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/widgets/home/main_drawer.dart';
import 'package:flutter/material.dart';

class ClientHomePage extends StatefulWidget {
  final String? uid;

  ClientHomePage({super.key, required this.uid});
  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    VendorView(),
    PlanningView(),
    ExploreView(),
    MessageView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue.withOpacity(0.5),
        centerTitle: true,
        title: Text(
          'Home Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: MainDrawer(
        uid: widget.uid,
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

class PlanningView extends StatelessWidget {
  const PlanningView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("data");
  }
}

class MessageView extends StatelessWidget {
  const MessageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Message Page');
  }
}

class ExploreView extends StatelessWidget {
  const ExploreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Profile Page');
  }
}

class VendorView extends StatelessWidget {
  VendorView({
    super.key,
  });
  final List<String> services = [
    'Venue Booking',
    'Catering',
    'Photography',
    'Entertainment (Music)',
    'Decorations',
    'Transportation',
    'Bridal Makeup & Hair',
    'Invitation Design',
    'Clothing',
    'Sweets',
    'Videography',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              services[index],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, PageNames.MarriageHallVendorsScreen);
            },
          );
        });
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('home Page');
  }
}
