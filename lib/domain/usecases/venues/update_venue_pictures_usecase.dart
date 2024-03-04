import 'dart:io';

import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateVenuePicturesUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateVenuePicturesUsecase({required this.firebaseRepository});

  Future<void> call(String id, List<File>? images) async {
    return await firebaseRepository.UpdateVenuePictures(id, images);
  }
}
