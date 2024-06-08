import 'dart:io';

import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateVenueScreen extends StatefulWidget {
  UpdateVenueScreen({super.key, required this.venueEntity});
  final VenueEntity venueEntity;

  @override
  State<UpdateVenueScreen> createState() => _UpdateVenueScreenState();
}

class _UpdateVenueScreenState extends State<UpdateVenueScreen> {
  // String? _address;
  // int? _capacity;
  // String? _contact;
  // String? _description;
  List<String>? _facilities;

  // List of available facilities
  List<String> _availableFacilities = [
    'Wifi',
    'Parking',
    'Catering',
    'AC',
    'Projector Lights',
    'Stage',
    // Add more facilities as needed
  ];
  List<File> selectedImages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Venue'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                pickImages();
              },
              child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey[200],
                  child: ListView.builder(
                    itemCount: selectedImages.isNotEmpty
                        ? selectedImages.length
                        : widget.venueEntity.images!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: selectedImages.isNotEmpty
                              ? Image.file(
                                  selectedImages[index],
                                  width: 200,
                                  height: 180,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  widget.venueEntity.images![index],
                                  width: 200,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ));
                    },
                  )),
            ),
            Text(
              widget.venueEntity.name!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26, // Set the font size
              ),
            ),
            TextFormField(
              
              initialValue: widget.venueEntity.description,
              maxLines: null, // Allow unlimited lines
              keyboardType: TextInputType.multiline, // Enable multiline input
              decoration: InputDecoration(
                border: OutlineInputBorder(), // Box type decoration with border
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              initialValue: widget.venueEntity.contact,
              maxLines: 1, // Allow unlimited lines
              decoration: InputDecoration(
                border: OutlineInputBorder(), // Box type decoration with border
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              initialValue: widget.venueEntity.capacity.toString(),
              maxLines: 1, // Allow unlimited lines
              decoration: InputDecoration(
                border: OutlineInputBorder(), // Box type decoration with border
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _availableFacilities.length,
              itemBuilder: (context, index) {
                final facility = _availableFacilities[index];
                return CheckboxListTile(
                  title: Text(facility),
                  value: _facilities?.contains(facility) ?? false,
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked != null) {
                        if (_facilities == null) {
                          _facilities = [];
                        }
                        if (checked) {
                          _facilities!.add(facility);
                        } else {
                          _facilities!.remove(facility);
                        }
                      }
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // final String? address;

  // final Map<String, dynamic>? pricingInfo;
  // final Map<String, Map<String, bool>>? availability;

  Future<void> pickImages() async {
    final List<XFile>? result = await ImagePicker().pickMultiImage();
    if (result != null && result.isNotEmpty) {
      setState(() {
        selectedImages = result.map((XFile file) => File(file.path)).toList();
      });
    }
  }
}

  // Future<void> EditAvailabilityOfVenue

  // Future<void> UpdateVenuesPictures

  // Future<void> UpdateVenue
  