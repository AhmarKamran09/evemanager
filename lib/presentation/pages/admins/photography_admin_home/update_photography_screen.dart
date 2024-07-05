import 'dart:io';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/presentation/cubit/photography/photography_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePhotographyScreen extends StatefulWidget {
  UpdatePhotographyScreen({super.key, required this.photographyEntity});
  final PhotographyEntity photographyEntity;

  @override
  State<UpdatePhotographyScreen> createState() =>
      _UpdatePhotographyScreenState();
}

class _UpdatePhotographyScreenState extends State<UpdatePhotographyScreen> {
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String>? _services = [];

  List<File> selectedImages = [];

  List<String> _availableServices = [
    'Indoor Shooting',
    'Outdoor Shooting',
    'Studio Setup',
    'Lighting Equipment',
    'Wedding Photography',
    'Event Photography',
    'Portrait Photography',
    'Aerial Photography',
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0;
        i < (widget.photographyEntity.facilities?.length ?? 0);
        i++) {
      if (!_services!.contains(widget.photographyEntity.facilities![i])) {
        _services?.add(widget.photographyEntity.facilities![i]);
      }
    }

    contactController.text = widget.photographyEntity.contact ?? '';
    descriptionController.text = widget.photographyEntity.description ?? '';
    cityController.text = widget.photographyEntity.city ?? '';
    addressController.text = widget.photographyEntity.address ?? '';

    return BlocConsumer<PhotographyCubit, PhotographyState>(
      listener: (context, state) {
        if (state is PhotographySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Updated Successfully. Refresh to see updates'),
          ));
          Navigator.pop(context);
        } else if (state is PhotographyFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Some failure occurred'),
          ));
        }
      },
      builder: (BuildContext context, PhotographyState state) {
        if (state is PhotographyLoading) {
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
        title: Text('Update Photography'),
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
                      : widget.photographyEntity.images!.length,
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
                              widget.photographyEntity.images![index],
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
              widget.photographyEntity.name!,
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
                final valueBool = (_services?.contains(service) ?? false);
                return CheckboxListTile(
                  title: Text(service),
                  value: valueBool,
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked ?? false) {
                        if (!_services!.contains(service)) {
                          _services!.add(service);
                        }
                      } else {
                        _services!.removeWhere((element) => element == service);
                        if (widget.photographyEntity.facilities!
                            .contains(service)) {
                          widget.photographyEntity.facilities!
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
                  _updatePhotography(context);
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

  Future<void> _updatePhotography(BuildContext context) async {
    if (selectedImages.isEmpty) {
      selectedImages = widget.photographyEntity.images!;
    }

    await BlocProvider.of<PhotographyCubit>(context)
        .updatePhotography(PhotographyEntity(
      city: cityController.text,
      address: addressController.text,
      id: widget.photographyEntity.id,
      description: descriptionController.text,
      contact: contactController.text,
      facilities: _services,
      images: selectedImages,
    ));
    _services = [];
  }
}
