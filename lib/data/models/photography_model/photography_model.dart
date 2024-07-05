import 'package:evemanager/domain/entities/photography/photography_entity.dart';

class PhotographyModel extends PhotographyEntity {
  final String? id;
  final String? owner_id;
  final String? address;
  final List<String>? imageslink;
  final String? name;
  final String? contact;
  final List<String>? facilities;
  final String? description;
  final int? totalreviews;
  final double? rating;
  final String? city;

  PhotographyModel({    this.city,

    this.rating,
    this.totalreviews,
    this.imageslink,
    this.name,
    this.contact,
    this.facilities,
    this.description,
    this.id,
    this.owner_id,
    this.address,
  }) : super();

  Map<String, dynamic> toJson() => {    'city': city,

        'rating': rating,
        'totalreviews': totalreviews,
        'imageslink': imageslink,
        'name': name,
        'contact': contact,
        'facilities': facilities,
        'description': description,
        'id': id,
        'owner_id': owner_id,
        'address': address,
      };

  @override
  List<Object?> get props => [
        rating,
        totalreviews,
        imageslink,
        name,
        contact,
        facilities,
        description,
        id,
        owner_id,
        address,city,
      ];
}