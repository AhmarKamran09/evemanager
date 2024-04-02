import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/clothing/clothing_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_clothing_card.dart';

class ClothingAdminHome extends StatelessWidget {
  ClothingAdminHome({super.key, required this.uid});
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
          Navigator.pushNamed(context, PageNames.AddClothingScreen,
              arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<ClothingCubit>(context)
              .GetClothingForOwner(uid!);
        },
        child: FutureBuilder(
            future: BlocProvider.of<ClothingCubit>(context)
                .GetClothingForOwner(uid!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<ClothingCubit, ClothingState>(
                  listener: (context, state) {
                    if (state is ClothingFailure) {
                      DisplayToast('Failed To Get Clothing Services');
                    }
                  },
                  builder: (context, state) {
                    if (state is ClothingSuccessForOwner) {
                      if (state.clothing_entity?.isEmpty ?? false) {
                        return Center(
                          child: Text('No clothing Services listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.clothing_entity?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: AdminClothingCard(
                                      clothingEntity:
                                          state.clothing_entity![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is ClothingFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show clothing Services'),
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
