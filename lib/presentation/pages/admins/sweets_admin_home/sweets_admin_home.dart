import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/sweets/sweets_cubit.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/_admin_home_page/admin_sweets_card.dart';

class SweetsAdminHome extends StatelessWidget {
  SweetsAdminHome({Key? key, required this.uid});
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
          Navigator.pushNamed(context, PageNames.AddSweetsScreen, arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<SweetsCubit>(context).getSweetsForOwner(uid!);
        },
        child: FutureBuilder(
          future: BlocProvider.of<SweetsCubit>(context).getSweetsForOwner(uid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocConsumer<SweetsCubit, SweetsState>(
                listener: (context, state) {
                  if (state is SweetsFailure) {
                    DisplayToast('Failed To Get Sweets Services');
                  }
                },
                builder: (context, state) {
                  if (state is SweetsSuccessForOwner) {
                    if (state.sweets_entity?.isEmpty ?? false) {
                      return Center(
                        child: Text('No Sweets Services listed'),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.sweets_entity?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: AdminSweetsCard(
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
                        child: Text('Failed To Show Sweets Services'),
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
