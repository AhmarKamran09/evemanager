import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:evemanager/presentation/widgets/venue_admin_home/admin_venue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VenueAdminHome extends StatelessWidget {
  VenueAdminHome({
    super.key,
    required this.uid,
  });
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue.withOpacity(0.5),
        centerTitle: true,
        title: Text(
          'EVE MANAGER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {}, icon: Icon(Icons.messenger_outline_sharp)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, PageNames.ProfileMenuPage,
                    arguments: uid);
              },
              icon: Icon(size: 40, Icons.person)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageNames.AddVenuesScreen,
              arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<VenueCubit>(context).GetVenueForOwner(uid!);
        },
        child: FutureBuilder(
            future: BlocProvider.of<VenueCubit>(context).GetVenueForOwner(uid!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<VenueCubit, VenueState>(
                  listener: (context, state) {
                    if (state is VenueFailure) {
                      DisplayToast('Failed To Get Venues');
                    }
                  },
                  builder: (context, state) {
                    if (state is VenueSuccessForOwner) {
                      if (state.VenueEntities?.isEmpty ?? false) {
                        return Center(
                          child: Text('No Venues listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.VenueEntities?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: AdminVenueCard(
                                      venue: state.VenueEntities![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is VenueFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Venues'),
                        ),
                      );
                    } else {
                      return LoadingBody();
                    }
                  },
                );
              } else {
                return LoadingBody();
              }
            }),
      ),
    );
  }
}
