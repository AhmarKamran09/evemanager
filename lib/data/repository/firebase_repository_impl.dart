import 'dart:io';

import 'package:evemanager/data/datasource/firebase_datasource.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseDatasource firebaseDatasource;

  FirebaseRepositoryImpl({required this.firebaseDatasource});

  @override
  Future<void> DeleteUser(String uid) async {
    await firebaseDatasource.DeleteUser(uid);
  }

  @override
  Future<UserEntity> GetUser(String uid) async =>
      await firebaseDatasource.GetUser(uid);

  @override
  Future<bool> IsSignInUser() async => await firebaseDatasource.IsSignInUser();

  @override
  Future<void> SignOutUser() async {
    await firebaseDatasource.SignOutUser();
  }

  @override
  Future<bool> SignInUser(UserEntity user) async =>
      await firebaseDatasource.SignInUser(user);

  @override
  Future<void> SignUpUser(UserEntity user) async {
    await firebaseDatasource.SignUpUser(user);
  }

  @override
  Future<void> UpdateUser(UserEntity user) async {
    await firebaseDatasource.UpdateUser(user);
  }

  @override
  Future<String?> GetCurrentUid() async => firebaseDatasource.GetCurrentUid();

// Marriage Hall

  @override
  Future<void> AddVenue(VenueEntity venueEntity) {
    return firebaseDatasource.AddVenue(venueEntity);
  }

  @override
  Future<void> DeleteVenue(String id) {
    return firebaseDatasource.DeleteVenue(id);
  }

  @override
  Stream<List<VenueEntity>> GetVenueforClient() {
    return firebaseDatasource.GetVenueforClient();
  }

  @override
  Stream<List<VenueEntity>> GetVenueforOwner(String ownerid) {
    return firebaseDatasource.GetVenueforOwner(ownerid);
  }

  @override
  Future<void> UpdateVenue(VenueEntity venueEntity) {
    return firebaseDatasource.UpdateVenue(venueEntity);
  }

  @override
  Future<void> EditAvailabilityOfVenue(
      String hallid, Map<String, bool> availability) {
    return firebaseDatasource.EditAvailabilityOfVenue(hallid, availability);
  }

  @override
  Future<void> UpdateVenuePictures(
    String id,
    List<File>? images,
  ) {
    return firebaseDatasource.UpdateVenuePictures(id, images);
  }

  @override
  Future<void> AddCateringService(CateringEntity cateringEntity) {
    return firebaseDatasource.AddCateringService(cateringEntity);
  }

  @override
  Future<void> DeleteCateringService(String id) {
    return firebaseDatasource.DeleteCateringService(id);
  }

  @override
  Stream<List<CateringEntity>> GetCateringServiceforClient() {
    return firebaseDatasource.GetCateringServiceforClient();
  }

  @override
  Stream<List<CateringEntity>> GetCateringServiceforOwner(String ownerid) {
    return firebaseDatasource.GetCateringServiceforOwner(ownerid);
  }

  @override
  Future<void> UpdateCateringService(CateringEntity cateringEntity) {
    return firebaseDatasource.UpdateCateringService(cateringEntity);
  }
}
