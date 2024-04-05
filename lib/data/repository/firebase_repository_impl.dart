import 'dart:io';

import 'package:evemanager/constants.dart';
import 'package:evemanager/data/datasource/firebase_datasource.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/entities/planned_events/planned_events_entity.dart';
import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';
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

  @override
  Future<void> AddDecorations(DecorationsEntity decorationsEntity) {
    return firebaseDatasource.AddDecorations(decorationsEntity);
  }

  @override
  Future<void> DeleteDecorations(String id) {
    return firebaseDatasource.DeleteDecorations(id);
  }

  @override
  Stream<List<DecorationsEntity>> GetDecorationsforClient() {
    return firebaseDatasource.GetDecorationsforClient();
  }

  @override
  Stream<List<DecorationsEntity>> GetDecorationsforOwner(String ownerid) {
    return firebaseDatasource.GetDecorationsforOwner(ownerid);
  }

  @override
  Future<void> UpdateDecorations(DecorationsEntity decorationsEntity) {
    return firebaseDatasource.UpdateDecorations(decorationsEntity);
  }

  @override
  Future<void> AddEntertainment(EntertainmentEntity entertainmentEntity) {
    return firebaseDatasource.AddEntertainment(entertainmentEntity);
  }

  @override
  Future<void> DeleteEntertainment(String id) {
    return firebaseDatasource.DeleteEntertainment(id);
  }

  @override
  Future<void> UpdateEntertainment(EntertainmentEntity entertainmentEntity) {
    return firebaseDatasource.UpdateEntertainment(entertainmentEntity);
  }

  @override
  Stream<List<EntertainmentEntity>> GetEntertainmentforClient() {
    return firebaseDatasource.GetEntertainmentforClient();
  }

  @override
  Stream<List<EntertainmentEntity>> GetEntertainmentforOwner(String ownerid) {
    return firebaseDatasource.GetEntertainmentforOwner(ownerid);
  }

  @override
  Future<void> AddPhotography(PhotographyEntity photographyEntity) {
    return firebaseDatasource.AddPhotography(photographyEntity);
  }

  @override
  Future<void> DeletePhotography(String id) {
    return firebaseDatasource.DeletePhotography(id);
  }

  @override
  Future<void> UpdatePhotography(PhotographyEntity photographyEntity) {
    return firebaseDatasource.UpdatePhotography(photographyEntity);
  }

  @override
  Stream<List<PhotographyEntity>> GetPhotographyforClient() {
    return firebaseDatasource.GetPhotographyforClient();
  }

  @override
  Stream<List<PhotographyEntity>> GetPhotographyforOwner(String ownerid) {
    return firebaseDatasource.GetPhotographyforOwner(ownerid);
  }

  @override
  Future<void> AddSweets(SweetEntity sweetEntity) {
    return firebaseDatasource.AddSweets(sweetEntity);
  }

  @override
  Future<void> DeleteSweets(String id) {
    return firebaseDatasource.DeleteSweets(id);
  }

  @override
  Future<void> UpdateSweets(SweetEntity sweetEntity) {
    return firebaseDatasource.UpdateSweets(sweetEntity);
  }

  @override
  Stream<List<SweetEntity>> GetSweetsforClient() {
    return firebaseDatasource.GetSweetsforClient();
  }

  @override
  Stream<List<SweetEntity>> GetSweetsforOwner(String ownerid) {
    return firebaseDatasource.GetSweetsforOwner(ownerid);
  }

  @override
  Future<void> AddVideography(VideographyEntity videographyEntity) {
    return firebaseDatasource.AddVideography(videographyEntity);
  }

  @override
  Future<void> DeleteVideography(String id) {
    return firebaseDatasource.DeleteVideography(id);
  }

  @override
  Future<void> UpdateVideography(VideographyEntity videographyEntity) {
    return firebaseDatasource.UpdateVideography(videographyEntity);
  }

  @override
  Stream<List<VideographyEntity>> GetVideographyforClient() {
    return firebaseDatasource.GetVideographyforClient();
  }

  @override
  Stream<List<VideographyEntity>> GetVideographyforOwner(String ownerid) {
    return firebaseDatasource.GetVideographyforOwner(ownerid);
  }

  @override
  Future<void> AddPlannedEvents(PlannedEventEntity plannedEventEntity) {
    return firebaseDatasource.AddPlannedEvents(plannedEventEntity);
  }

  @override
  Future<void> DeletePlannedEvents(String id) {
    return firebaseDatasource.DeletePlannedEvents(id);
  }

  @override
  Stream<List<PlannedEventEntity>> GetPlannedEvents(String userid) {
    return firebaseDatasource.GetPlannedEvents(userid);
  }

  @override
  Stream<List<MessageEntity>> GetMessages({
    required ChatEntity chatEntity,
    required UserRole userRole,
    required String request_sender_id,
  }) {
    return firebaseDatasource.GetMessages(
        chatEntity: chatEntity,
        userRole: userRole,
        request_sender_id: request_sender_id);
  }

  @override
  Future<void> SendMessage(
      {required MessageEntity messageEntity,
      required String clientid,
      required ServiceEntity serviceEntity}) {
    return firebaseDatasource.SendMessage(
        clientid: clientid,
        messageEntity: messageEntity,
        serviceEntity: serviceEntity);
  }

  @override
  Stream<List<ChatEntity>> GetChatsForClient(String userid) {
    return firebaseDatasource.GetChatsForClient(userid);
  }

  @override
  Stream<List<ChatEntity>> GetChatsForAdmin(String userid) {
    return firebaseDatasource.GetChatsForAdmin(userid);
  }

  @override
  Future<void> AddRating(RatingEntity ratingEntity) {
    return firebaseDatasource.AddRating(ratingEntity);
  }

  @override
  Stream<List<RatingEntity>> GetRating(String serviceId) {
    return firebaseDatasource.GetRating(serviceId);
  }
}
