import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/videography/videography_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_videography_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideographyListScreen extends StatelessWidget {
  const VideographyListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videography Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<VideographyCubit>(context).getVideographyForClient();
        },
        child: FutureBuilder(
          future: BlocProvider.of<VideographyCubit>(context).getVideographyForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<VideographyCubit, VideographyState>(
                listener: (context, state) {
                  if (state is VideographyFailure) {
                    DisplayToast('Failed To Get Videography Services');
                  }
                },
                builder: (context, state) {
                  if (state is VideographySuccessForClient) {
                    if (state.videography_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No videography services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.videography_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ClientVideographyCard(
                                videographyEntity: state.videography_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is VideographyFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Videography service'),
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
