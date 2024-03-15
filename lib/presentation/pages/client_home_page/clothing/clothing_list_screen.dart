import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/clothing/clothing_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_clothing_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClothingListScreen extends StatelessWidget {
  const ClothingListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clothing Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<ClothingCubit>(context).GetClothingForClient();
        },
        child: FutureBuilder(
          future: BlocProvider.of<ClothingCubit>(context).GetClothingForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<ClothingCubit, ClothingState>(
                listener: (context, state) {
                  if (state is ClothingFailure) {
                    DisplayToast('Failed To Get Clothing Services');
                  }
                },
                builder: (context, state) {
                  if (state is ClothingSuccessForClient) {
                    if (state.clothing_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No clothing services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.clothing_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ClientClothingCard(
                                clothingEntity: state.clothing_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is ClothingFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Clothing Service'),
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
