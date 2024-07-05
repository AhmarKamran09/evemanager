import 'package:evemanager/domain/entities/venues/venue_entity.dart';

class VenueModel extends VenueEntity {
  final String? id;
  final String? owner_id;
  final String? address;
  final List<String>? imageslink;
  final String? name;
  final int? capacity;
  final String? contact;
  final List<String>? facilities;
  final String? description;
  final int? totalreviews;
  final double? rating;
  final String? city;

  VenueModel({
    this.city,
    this.rating,
    this.totalreviews,
    this.imageslink,
    this.name,
    this.capacity,
    this.contact,
    this.facilities,
    this.description,
    this.id,
    this.owner_id,
    this.address,
  }) : super();

  Map<String, dynamic> toJson() => {
        'city': city,
        'rating': rating,
        'totalreviews': totalreviews,
        'imageslink': imageslink,
        'name': name,
        'capacity': capacity,
        'contact': contact,
        'facilities': facilities,
        'description': description,
        'id': id,
        'owner_id': owner_id,
        'address': address,
      };

  @override
  List<Object?> get props => [
        city,
        rating,
        totalreviews,
        imageslink,
        name,
        capacity,
        contact,
        facilities,
        description,
        id,
        owner_id,
        address,
      ];
}
