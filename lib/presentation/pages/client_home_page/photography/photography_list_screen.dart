import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/photography/photography_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_photography_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotographyListScreen extends StatelessWidget {
  const PhotographyListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photography Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<PhotographyCubit>(context).getPhotographyForClient();
        },
        child: FutureBuilder(
          future: BlocProvider.of<PhotographyCubit>(context).getPhotographyForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<PhotographyCubit, PhotographyState>(
                listener: (context, state) {
                  if (state is PhotographyFailure) {
                    DisplayToast('Failed To Get Photography Services');
                  }
                },
                builder: (context, state) {
                  if (state is PhotographySuccessForClient) {
                    if (state.photography_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No photography services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.photography_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ClientPhotographyCard(
                                photographyEntity: state.photography_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is PhotographyFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Photography Services'),
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
