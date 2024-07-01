import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';

class VenueEntity extends ServiceEntity {
  final int? capacity;

  VenueEntity({
    this.capacity,
    String? id,
    String? owner_id,
    String? name,
    String? contact,
    String? address,
    List<File>? images,
    List<String>? facilities,
    String? description,
    Map<String, dynamic>? pricingInfo,
    int? totalreviews,
    double? rating,
  }) : super(
            images: images,
            name: name,
            contact: contact,
            facilities: facilities,
            pricingInfo: pricingInfo,
            description: description,
            id: id,
            owner_id: owner_id,
            address: address,
            totalreviews: totalreviews,
            rating: rating);

  factory VenueEntity.factory(
      DocumentSnapshot snapshot, List<File>? imagesfromstorage) {
    var snap = snapshot.data() as Map<String, dynamic>;
    List<String> facilitiesmodel = [];
    for (int i = 0; i < snap['facilities'].length; i++) {
      facilitiesmodel.add(snap['facilities'][i].toString());
    }

    return VenueEntity(
      images: imagesfromstorage,
      name: snap['name'],
      capacity: snap['capacity'],
      contact: snap['contact'],
      // facilities: snap['facilities'] as List<String>,
      facilities: facilitiesmodel,
      pricingInfo: snap['pricingInfo'],
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
        rating,
        totalreviews,
        capacity,
        images,
        name,
        contact,
        facilities,
        pricingInfo,
        description,
        id,
        owner_id,
        address,
      ];
}
