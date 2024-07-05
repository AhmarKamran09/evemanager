// import 'package:evemanager/domain/entities/videography/videography_entity.dart';
// import 'package:flutter/material.dart';

// class UpdateVideographyScreen extends StatelessWidget {
//   const UpdateVideographyScreen({Key? key, required this.videographyEntity});
//   final VideographyEntity videographyEntity;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'dart:io';

import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:evemanager/presentation/cubit/videography/videography_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateVideographyScreen extends StatefulWidget {
  UpdateVideographyScreen({super.key, required this.videographyEntity});
  final VideographyEntity videographyEntity;

  @override
  State<UpdateVideographyScreen> createState() =>
      _UpdateVideographyScreenState();
}

class _UpdateVideographyScreenState extends State<UpdateVideographyScreen> {
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String>? _facilities = [];

  List<File> selectedImages = [];

  List<String> _availableServices = [
    'Wedding Videos',
    'Event Coverage',
    'Cinematography',
    'Drone Footage',
    'Editing Services',
    'Live Streaming',
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0;
        i < (widget.videographyEntity.facilities?.length ?? 0);
        i++) {
      if (!_facilities!.contains(widget.videographyEntity.facilities![i])) {
        _facilities?.add(widget.videographyEntity.facilities![i]);
      }
    }

    contactController.text = widget.videographyEntity.contact ?? '';
    descriptionController.text = widget.videographyEntity.description ?? '';
    cityController.text = widget.videographyEntity.city ?? '';
    addressController.text = widget.videographyEntity.address ?? '';

    return BlocConsumer<VideographyCubit, VideographyState>(
      listener: (context, state) {
        if (state is VideographySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Updated Successfully. Refresh to see updates'),
          ));
          Navigator.pop(context);
        } else if (state is VideographyFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Some failure occurred'),
          ));
        }
      },
      builder: (BuildContext context, VideographyState state) {
        if (state is VideographyLoading) {
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
        title: Text('Update Videography'),
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
                      : widget.videographyEntity.images!.length,
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
                              widget.videographyEntity.images![index],
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
              widget.videographyEntity.name!,
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
                        if (widget.videographyEntity.facilities!
                            .contains(service)) {
                          widget.videographyEntity.facilities!
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
                  _updateVideography(context);
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

  Future<void> _updateVideography(BuildContext context) async {
    if (selectedImages.isEmpty) {
      selectedImages = widget.videographyEntity.images!;
    }

    await BlocProvider.of<VideographyCubit>(context)
        .updateVideography(VideographyEntity(
      city: cityController.text,
      address: addressController.text,
      id: widget.videographyEntity.id,
      description: descriptionController.text,
      contact: contactController.text,
      facilities: _facilities,
      images: selectedImages,
    ));
    _facilities = [];
  }
}
