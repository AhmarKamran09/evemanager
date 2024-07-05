import 'dart:io';

import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCateringScreen extends StatefulWidget {
  UpdateCateringScreen({super.key, required this.cateringEntity});
  final CateringEntity cateringEntity;

  @override
  State<UpdateCateringScreen> createState() => _UpdateCateringScreenState();
}

class _UpdateCateringScreenState extends State<UpdateCateringScreen> {
  TextEditingController capacityController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String>? _facilities = [];

  List<File> selectedImages = [];

  List<String> _availableServices = [
    'Buffet',
    'Plated',
    'Family Style',
    'Cocktail Reception',
    'Food Stations',
    'Dessert Table',
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < (widget.cateringEntity.facilities?.length ?? 0); i++) {
      if (!_facilities!.contains(widget.cateringEntity.facilities![i])) {
        _facilities?.add(widget.cateringEntity.facilities![i]);
      }
    }

    contactController.text = widget.cateringEntity.contact ?? '';
    descriptionController.text = widget.cateringEntity.description ?? '';
    cityController.text = widget.cateringEntity.city ?? '';
    addressController.text = widget.cateringEntity.address ?? '';

    return BlocConsumer<CateringserviceCubit, CateringserviceState>(
      listener: (context, state) {
        if (state is CateringserviceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Updated Successfully. Refresh to see updates'),
          ));
          Navigator.pop(context);
        } else if (state is CateringserviceFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Some failure occurred'),
          ));
        }
      },
      builder: (BuildContext context, CateringserviceState state) {
        if (state is CateringserviceLoading) {
          return Stack(
            children: [
              _body(context),
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        } else {
          return _body(context);
        }
      },
    );
  }

  Scaffold _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Catering'),
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
                      : widget.cateringEntity.images!.length,
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
                              widget.cateringEntity.images![index],
                              width: 200,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                    );
                  },
                ),
              ),
            ),
            Text(
              widget.cateringEntity.name!,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: contactController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Contact',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: capacityController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Capacity',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: cityController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: addressController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _availableServices.length,
              itemBuilder: (context, index) {
                final service = _availableServices[index];
                final valueBool = (_facilities?.contains(service) ?? false);
                return CheckboxListTile(
                  title: Text(service),
                  value: valueBool,
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked ?? false) {
                        if (!_facilities!.contains(service)) {
                          _facilities!.add(service);
                        }
                      } else {
                        _facilities!
                            .removeWhere((element) => element == service);
                        if (widget.cateringEntity.facilities!
                            .contains(service)) {
                          widget.cateringEntity.facilities!
                              .removeWhere((element) => element == service);
                        }
                      }
                    });
                  },
                );
              },
            ),
            Container(
              color: Colors.lightBlue.withOpacity(0.5),
              child: TextButton(
                onPressed: () {
                  _updateCatering(context);
                },
                child: Text('Save'),
              ),
            ),
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

  Future<void> _updateCatering(BuildContext context) async {
    if (selectedImages.isEmpty) {
      selectedImages = widget.cateringEntity.images!;
    }

    await BlocProvider.of<CateringserviceCubit>(context)
        .UpdateCateringService(CateringEntity(
      city: cityController.text,
      address: addressController.text,
      id: widget.cateringEntity.id,
      description: descriptionController.text,
      contact: contactController.text,
      facilities: _facilities,
      images: selectedImages,
    ));
    _facilities = [];
  }
}
