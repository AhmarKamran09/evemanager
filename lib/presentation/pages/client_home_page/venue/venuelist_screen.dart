import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_venues_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VenueListScreen extends StatelessWidget {
  final String uid;

  const VenueListScreen({super.key, required this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venues"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<VenueCubit>(context).GetVenueForClient();
        },
        child: FutureBuilder(
            future: BlocProvider.of<VenueCubit>(context).GetVenueForClient(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<VenueCubit, VenueState>(
                  listener: (context, state) {
                    if (state is VenueFailure) {
                      DisplayToast('Failed To Get Venues');
                    }
                  },
                  builder: (context, state) {
                    print(state);
                    if (state is VenueSuccessForClient) {
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
                                  child: ClientVenuesCard(
                                      uid: uid,
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
