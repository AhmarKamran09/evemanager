import 'dart:io';

import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateMarriageHallPicturesUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateMarriageHallPicturesUsecase({required this.firebaseRepository});

  Future<void> call(String id, List<File>? images) async {
    return await firebaseRepository.UpdateMarriageHallPictures(
        id, images);
  }
}
