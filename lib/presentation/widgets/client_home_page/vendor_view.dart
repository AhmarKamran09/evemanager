import 'package:evemanager/constants.dart';
import 'package:flutter/material.dart';

class VendorView extends StatelessWidget {
  VendorView({
    super.key,
    required this.uid,
  });
  final String uid;
  final List<String> services = [
    'Venue Booking',
    'Catering',
    'Sweets',
    'Decorations',
    'Photography',
    'Videography',
    'Entertainment (Music)',
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
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, PageNames.VenueListScreen,
                      arguments: uid);

                  break;
                case 1:
                  Navigator.pushNamed(context, PageNames.CateringListScreen);

                  break;
                case 2:
                  Navigator.pushNamed(context, PageNames.SweetsListScreen);

                  break;
                case 3:
                  Navigator.pushNamed(context, PageNames.DecorationListScreen);

                  break;
                case 4:
                  Navigator.pushNamed(context, PageNames.PhotographyListScreen);

                  break;
                case 5:
                  Navigator.pushNamed(context, PageNames.VideographyListScreen);

                  break;
                case 6:
                  Navigator.pushNamed(
                      context, PageNames.EntertainmentListScreen);

                  break;

                default:
                  Navigator.pushNamed(context, PageNames.PageNotFound);
              }
            },
          );
        });
  }
}
