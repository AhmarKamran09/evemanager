import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/decoration/decoration_cubit.dart';
import 'package:evemanager/presentation/widgets/client_home_page/client_decoration_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DecorationListScreen extends StatelessWidget {
  const DecorationListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Decoration Services"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<DecorationCubit>(context).GetDecorationsForClient();
        },
        child: FutureBuilder(
          future: BlocProvider.of<DecorationCubit>(context).GetDecorationsForClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<DecorationCubit, DecorationState>(
                listener: (context, state) {
                  if (state is DecorationsFailure) {
                    DisplayToast('Failed To Get Decoration Services');
                  }
                },
                builder: (context, state) {
                  if (state is DecorationsSuccessForClient) {
                    if (state.decorations_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No decoration services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.decorations_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ClientDecorationCard(
                                decorationEntity: state.decorations_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is DecorationsFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Decoration service'),
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
