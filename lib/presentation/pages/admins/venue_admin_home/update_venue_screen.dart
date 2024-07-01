import 'dart:io';

import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cubit/venue/venue_cubit.dart';

class UpdateVenueScreen extends StatefulWidget {
  UpdateVenueScreen({super.key, required this.venueEntity});
  final VenueEntity venueEntity;

  @override
  State<UpdateVenueScreen> createState() => _UpdateVenueScreenState();
}

class _UpdateVenueScreenState extends State<UpdateVenueScreen> {
  TextEditingController capacitycontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  List<String>? _facilities = [];

  List<File> selectedImages = [];

  Map<String, dynamic>? pricingInfo;

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
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < (widget.venueEntity.facilities?.length ?? 0); i++) {
      if (!_facilities!.contains(widget.venueEntity.facilities![i])) {
        _facilities?.add(widget.venueEntity.facilities![i]);
      }
    }

    capacitycontroller.text = widget.venueEntity.capacity!.toString();
    contactcontroller.text = widget.venueEntity.contact!;
    descriptioncontroller.text = widget.venueEntity.description!;

    return BlocConsumer<VenueCubit, VenueState>(listener: (context, state) {
      if (state is VenueSuccess) {
        DisplayToast('Updated Successfully. Refresh To See Updates');
        Navigator.pop(context);
      } else if (state is VenueFailure) {
        DisplayToast('Some Failure Occurred');
      }
    }, builder: (BuildContext context, VenueState state) {
      if (state is VenueLoading) {
        return PopScope(
          canPop: false,
          child: Stack(
            children: [
              _body(context),
              Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent black background
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      } else
        return _body(context);
    });
  }

  Scaffold _body(BuildContext context) {
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
            Text(widget.venueEntity.name!),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: descriptioncontroller,
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
              controller: contactcontroller,
              maxLines: 1, // Allow unlimited lines
              decoration: InputDecoration(
                border: OutlineInputBorder(), // Box type decoration with border
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: capacitycontroller,
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
                final valuebool = (_facilities?.contains(facility) ?? false);
                return CheckboxListTile(
                  title: Text(facility),
                  value: valuebool,
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked ?? false) {
                        if (!_facilities!.contains(facility)) {
                          _facilities!.add(facility);
                        }
                      } else {
                        _facilities!
                            .removeWhere((element) => element == facility);
                        if (widget.venueEntity.facilities!.contains(facility)) {
                          widget.venueEntity.facilities!
                              .removeWhere((element) => element == facility);
                        }
                      }
                    });
                  },
                );
              },
            ),
            Container(
              color: lightBlue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  _updatevenue(context);
                },
                child: Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImages() async {
    final List<XFile>? result = await ImagePicker().pickMultiImage();
    if (result != null && result.isNotEmpty) {
      setState(() {
        selectedImages = result.map((XFile file) => File(file.path)).toList();
      });
    }
  }

  Future<void> _updatevenue(BuildContext context) async {
    if (selectedImages.isEmpty) {
      selectedImages = widget.venueEntity.images!;
    }

    await BlocProvider.of<VenueCubit>(context).UpdateVenue(VenueEntity(
      id: widget.venueEntity.id,
      description: descriptioncontroller.text,
      contact: contactcontroller.text,
      capacity: int.parse(capacitycontroller.text),
      facilities: _facilities,
      pricingInfo: pricingInfo,
      images: selectedImages,
    ));
    _facilities = [];
  }
}
