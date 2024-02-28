import 'dart:io';

import 'package:evemanager/data/datasource/firebase_datasource.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
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
  Future<void> AddMarriageHall(MarriageHallEntity marriageHallEntity) {
    return firebaseDatasource.AddMarriageHall(marriageHallEntity);
  }

  @override
  Future<void> DeleteMarriageHall(String id) {
    return firebaseDatasource.DeleteMarriageHall(id);
  }

  @override
  Stream<List<MarriageHallEntity>> GetMarriageHallforClient() {
    return firebaseDatasource.GetMarriageHallforClient();
  }

  @override
  Stream<List<MarriageHallEntity>> GetMarriageHallforOwner(String ownerid) {
    return firebaseDatasource.GetMarriageHallforOwner(ownerid);
  }

  @override
  Future<void> UpdateMarriageHall(MarriageHallEntity marriageHallEntity) {
    return firebaseDatasource.UpdateMarriageHall(marriageHallEntity);
  }

  @override
  Future<void> EditAvailabilityOfHall(
      String hallid, Map<String, bool> availability) {
    return firebaseDatasource.EditAvailabilityOfHall(hallid, availability);
  }

  @override
  Future<void> UpdateMarriageHallPictures(
    String id,
    List<File>? images,
  ) {
    return firebaseDatasource.UpdateMarriageHallPictures(id, images);
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
