import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/presentation/cubit/marriagehall/marriage_hall_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarriageHallVendorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venues"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<MarriageHallCubit>(context)
              .GetMarriageHallForClient();
        },
        child: FutureBuilder(
            future: BlocProvider.of<MarriageHallCubit>(context)
                .GetMarriageHallForClient(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<MarriageHallCubit, MarriageHallState>(
                  listener: (context, state) {
                    if (state is MarriageHallFailure) {
                      DisplayToast('Failed To Get Marriage Halls');
                    }
                  },
                  builder: (context, state) {
                    if (state is MarriageHallSuccessForClient) {
                      if (state.marriageHallEntities?.isEmpty ?? false) {
                        return Center(
                          child: Text('No wedding halls listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.marriageHallEntities?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: BuildHallCardForMarriageHall(
                                      hallData:
                                          state.marriageHallEntities![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is MarriageHallFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Wedding Halls'),
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

class BuildHallCardForMarriageHall extends StatelessWidget {
  BuildHallCardForMarriageHall({super.key, required this.hallData});
  final MarriageHallEntity hallData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              hallData.images![0],
              width: 200,
              height: 180,
              fit: BoxFit.cover,
            ),
          ), // Other details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hallData.name!,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Capacity: ${hallData.capacity}'),
                Text('Contact: ${hallData.contact}'),
                (hallData.availability == null || hallData.pricingInfo == null)
                    ? Text(
                        'Not published ',
                        style: TextStyle(color: Colors.red),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
