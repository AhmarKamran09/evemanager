import 'package:evemanager/domain/entities/catering/catering_entity.dart';

class CateringModel extends CateringEntity {
  final String? id;
  final String? owner_id;
  final String? address;
  final List<String>? imageslink;
  final String? name;
  final String? contact;
  final List<String>? facilities;
  final String? description;
  // final List<String>? cuisinetype;
  // final List<MenuItem>? menu;
  final int? totalreviews;
  final double? rating;
  final String? city;

  CateringModel({
    this.city,
    this.totalreviews,
    this.rating,
    // this.cuisinetype,
    // this.menu,
    this.imageslink,
    this.name,
    this.contact,
    this.facilities,
    this.description,
    this.id,
    this.owner_id,
    this.address,
  }) : super();

  Map<String, dynamic> toJson() => {
    'city':city,
        'rating': rating,
        'totalreviews': totalreviews,
        // 'menu': menu,
        // 'cuisinetype': cuisinetype,
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
    city,
        totalreviews,
        rating,
        // cuisinetype,
        // menu,
        imageslink,
        name,
        contact,
        facilities,
        description,
        id,
        owner_id,
        address,
      ];
}
