import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/sweets/sweets_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_sweets_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SweetsListScreen extends StatelessWidget {
  const SweetsListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sweets Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<SweetsCubit>(context).getSweetsForClient();
        },
        child: FutureBuilder(
          future: BlocProvider.of<SweetsCubit>(context).getSweetsForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<SweetsCubit, SweetsState>(
                listener: (context, state) {
                  if (state is SweetsFailure) {
                    DisplayToast('Failed To Get Sweets Services');
                  }
                },
                builder: (context, state) {
                  if (state is SweetsSuccessForClient) {
                    if (state.sweets_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No sweets services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.sweets_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ClientSweetsCard(
                                sweetsEntity: state.sweets_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is SweetsFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Sweets service'),
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
