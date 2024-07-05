class ServiceModel {
  final String? id;
  final String? owner_id;
  final String? address;
  final List<String>? imageslink;
  final String? name;
  final String? contact;
  final List<String>? facilities;
  final String? description;
  final int? totalreviews;
  final double? rating;  final String? city;


  ServiceModel({
    this.city,
    this.totalreviews,
    this.rating,
    this.imageslink,
    this.name,
    this.contact,
    this.facilities,
    this.description,
    this.id,
    this.owner_id,
    this.address,
  });
}
