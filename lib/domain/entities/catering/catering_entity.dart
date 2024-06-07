import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';

class CateringEntity extends ServiceEntity {
  final List<String>? cuisinetype;
  final List<MenuItem>? menu;

  CateringEntity({
    String? id,
    String? owner_id,
    String? name,
    String? contact,
    String? address,
    List<File>? images,
    List<String>? facilities,
    String? description,
    Map<String, dynamic>? pricingInfo,
    this.menu,
    this.cuisinetype,
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

  factory CateringEntity.factory(
      DocumentSnapshot snapshot, List<File>? imagesfromstorage) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return CateringEntity(
      cuisinetype: snap['cuisinetype'],
      menu: snap['menu'], images: imagesfromstorage,
      name: snap['name'],
      contact: snap['contact'],
      // facilities: snap['facilities'],
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
        cuisinetype,
        menu,
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

class MenuItem {
  final String name;
  final String description;
  final double price;
  final List<String> dietaryInfo;
  final String serving;

  MenuItem({
    required this.serving,
    required this.name,
    required this.description,
    required this.price,
    required this.dietaryInfo,
  });
}
