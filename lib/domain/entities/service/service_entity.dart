import 'dart:io';
import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String? id;
  final String? owner_id;
  final String? name;
  final String? contact;
  final String? address;
  final String? city;
  final List<File>? images;
  final List<String>? facilities;
  final String? description;

  final int? totalreviews;
  final double? rating;

  ServiceEntity({
    this.city,
    this.rating,
    this.totalreviews,
    this.id,
    this.owner_id,
    this.name,
    this.contact,
    this.address,
    this.images,
    this.facilities,
    this.description,
  });
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
