import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/decoration/decoration_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_decoration_card.dart';

class DecorationAdminHome extends StatelessWidget {
  DecorationAdminHome({Key? key, required this.uid});
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue.withOpacity(0.5),
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
          Navigator.pushNamed(context, PageNames.AddDecorationScreen, arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<DecorationCubit>(context).GetDecorationsForOwner(uid!);
        },
        child: FutureBuilder(
          future: BlocProvider.of<DecorationCubit>(context).GetDecorationsForOwner(uid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<DecorationCubit, DecorationState>(
                listener: (context, state) {
                  if (state is DecorationsFailure) {
                    DisplayToast('Failed To Get Decoration Services');
                  }
                },
                builder: (context, state) {
                  if (state is DecorationsSuccessForOwner) {
                    if (state.decorations_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No Decoration Services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.decorations_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: AdminDecorationCard(
                                decorationsEntity: state.decorations_entity![index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is DecorationsFailure) {
                    return Center(
                      child: Container(
                        child: Text('Failed To Show Decoration Services'),
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
