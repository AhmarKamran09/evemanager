import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';

class DecorationsEntity extends ServiceEntity {
  DecorationsEntity({
    String? city,
    String? id,
    String? owner_id,
    String? name,
    String? contact,
    String? address,
    List<File>? images,
    List<String>? facilities,
    String? description,
    int? totalreviews,
    double? rating,
  }) : super(
            city: city,
            images: images,
            name: name,
            contact: contact,
            facilities: facilities,
            description: description,
            id: id,
            owner_id: owner_id,
            address: address,
            totalreviews: totalreviews,
            rating: rating);

  factory DecorationsEntity.factory(
      DocumentSnapshot snapshot, List<File>? imagesfromstorage) {
    var snap = snapshot.data() as Map<String, dynamic>;
    List<String> facilitiesmodel = [];
    for (int i = 0; i < snap['facilities'].length; i++) {
      facilitiesmodel.add(snap['facilities'][i].toString());
    }

    return DecorationsEntity(
      city: snap['city'],
      images: imagesfromstorage,
      name: snap['name'],
      contact: snap['contact'],
      facilities: facilitiesmodel,
      description: snap['description'],
      id: snap['id'],
      owner_id: snap['owner_id'],
      address: snap['address'],
      rating: double.tryParse(snap['rating'].toString()),
      totalreviews: snap['totalreviews'],
    );
  }

  @override
  List<Object?> get props => [
        city,
        rating,
        totalreviews,
        images,
        name,
        contact,
        facilities,
        description,
        id,
        owner_id,
        address,
      ];
}
