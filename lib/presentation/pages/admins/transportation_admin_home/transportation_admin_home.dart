import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/transportation/transportation_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_transportation_card.dart';

class TransportationAdminHome extends StatelessWidget {
  TransportationAdminHome({Key? key, required this.uid});
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'EVE MANAGER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, PageNames.ProfileMenuPage, arguments: uid);
            },
            icon: Icon(Icons.person, size: 40),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageNames.AddTransportationScreen, arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<TransportationCubit>(context).getTransportationForOwner(uid!);
        },
        child: FutureBuilder(
          future: BlocProvider.of<TransportationCubit>(context).getTransportationForOwner(uid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<TransportationCubit, TransportationState>(
                listener: (context, state) {
                  if (state is TransportationFailure) {
                    DisplayToast('Failed To Get Transportation Services');
                  }
                },
                builder: (context, state) {
                  if (state is TransportationSuccessForOwner) {
                    if (state.transportation_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No Transportation Services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.transportation_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: AdminTransportationCard(
                                transportationEntity: state.transportation_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is TransportationFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Transportation Services'),
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
          },
        ),
      ),
    );
  }
}
