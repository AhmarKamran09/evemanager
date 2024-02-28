import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/presentation/cubit/marriagehall/marriage_hall_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildHallCard extends StatelessWidget {
  BuildHallCard({super.key, required this.hallData});
  final MarriageHallEntity hallData;

  @override
  Widget build(BuildContext context) {
     return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    hallData.images != null &&
                            hallData.images!.isNotEmpty // Example of null check
                        ? Image.file(
                            hallData.images![0],
                            width: 200,
                            height: 180,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(),
              ), // Other details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hallData.name ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Capacity: ${hallData.capacity ?? ""}'),
                    Text('Contact: ${hallData.contact ?? ""}'),
                    (hallData.availability == null ||
                            hallData.pricingInfo == null)
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
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, PageNames.UpdateMarriageHallScreen,
                        arguments: hallData);
                  },
                  icon: Icon(Icons.update)),
              IconButton(
                  onPressed: () {
                    _deletemarriagehall(context, hallData);
                  },
                  icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }

  void _deletemarriagehall(
      BuildContext context, MarriageHallEntity hallData) async {
    await BlocProvider.of<MarriageHallCubit>(context)
        .DeleteMarriageHall(hallid: hallData.id!, owner_id: hallData.owner_id!);
  }
}
