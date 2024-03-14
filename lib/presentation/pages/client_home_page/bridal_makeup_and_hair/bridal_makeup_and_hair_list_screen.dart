import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/bridal_makeup_and_hair/bridal_makeup_hair_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_bridal_makeup_hair_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BridalMakeupAndHairListScreen extends StatelessWidget {
  const BridalMakeupAndHairListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bridal Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<BridalMakeupHairCubit>(context)
              .GetBridalMakeupHairForClient();
        },
        child: FutureBuilder(
            future: BlocProvider.of<BridalMakeupHairCubit>(context)
                .GetBridalMakeupHairForClient(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<BridalMakeupHairCubit, BridalMakeupHairState>(
                  listener: (context, state) {
                    if (state is BridalMakeupHairFailure) {
                      DisplayToast('Failed To Get Bridal Services');
                    }
                  },
                  builder: (context, state) {
                    if (state is BridalMakeupHairSuccessForClient) {
                      if (state.bridal_makeup_entity?.isEmpty ?? false) {
                        return Center(
                          child: Text('No bridal services listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.bridal_makeup_entity?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: ClientBridalMakeupHairCard(
                                      bridalMakeupAndHairEntity:
                                          state.bridal_makeup_entity![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is BridalMakeupHairFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Bridal service'),
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
