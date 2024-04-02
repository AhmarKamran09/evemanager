import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:evemanager/presentation/widgets/_admin_home_page/admin_catering_service_card.dart';
import 'package:evemanager/presentation/widgets/loading_screen/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateringAdminHome extends StatelessWidget {
  CateringAdminHome({
    super.key,
    required this.uid,
  });
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
          Navigator.pushNamed(context, PageNames.AddCateringScreen,
              arguments: uid);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<CateringserviceCubit>(context)
              .GetCateringServiceForOwner(uid!);
        },
        child: FutureBuilder(
            future: BlocProvider.of<CateringserviceCubit>(context)
                .GetCateringServiceForOwner(uid!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocConsumer<CateringserviceCubit, CateringserviceState>(
                  listener: (context, state) {
                    if (state is CateringserviceFailure) {
                      DisplayToast('Failed To Get Catering Services');
                    }
                  },
                  builder: (context, state) {
                    if (state is CateringserviceSuccessForOwner) {
                      if (state.catering_entities?.isEmpty ?? false) {
                        return Center(
                          child: Text('No Catering Services listed'),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: state.catering_entities?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: AdminCateringServiceCard(
                                      cateringEntity:
                                          state.catering_entities![index]));
                            },
                          ),
                        );
                      }
                    } else if (state is CateringserviceFailure) {
                      return Center(
                        child: Container(
                          child: Text('Failed To Show Catering Services'),
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
