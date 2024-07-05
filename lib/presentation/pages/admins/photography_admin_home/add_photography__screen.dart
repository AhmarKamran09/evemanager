import 'dart:io';

import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/presentation/cubit/photography/photography_cubit.dart';
import 'package:evemanager/presentation/widgets/Credentials/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotographyScreen extends StatefulWidget {
  const AddPhotographyScreen({
    required this.uid,
    super.key,
  });
  final String uid;

  @override
  State<AddPhotographyScreen> createState() => _AddPhotographyScreenState();
}

class _AddPhotographyScreenState extends State<AddPhotographyScreen> {
  List<File> selectedImages = [];

  List<String> _availableFacilities = [
    'Indoor Shooting',
    'Outdoor Shooting',
    'Studio Setup',
    'Lighting Equipment',
     'Wedding Photography',
    'Event Photography',
    'Portrait Photography',
    'Aerial Photography',
  ];
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController description = TextEditingController();
  List<String>? _facilities = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotographyCubit, PhotographyState>(listener: (context, state) {
      if (name.text.isNotEmpty) {
        if (state is PhotographySuccessForOwner) {
          DisplayToast('Photography Added Successfully');
          Navigator.pop(context);
        } else if (state is PhotographyFailure) {
          DisplayToast('Some Failure Occurred');
        }
      }
    }, builder: (BuildContext context, PhotographyState state) {
      if (state is PhotographyLoading) {
        return PopScope(
          canPop: false,
          child: Stack(
            children: [
              _body(context, widget.uid),
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
        return _body(context, widget.uid);
    });
  }

  Scaffold _body(BuildContext context, String uid) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Photography'),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              pickImages();
            },
            child: Container(
              margin: EdgeInsets.all(16),
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: selectedImages.isNotEmpty
                  ? ListView.builder(
                      itemCount: selectedImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            selectedImages[index],
                            width: 200,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('Tap to select images'),
                    ),
            ),
          ),
          MyTextField(
            fieldvalue: name,
            label: "Name",
            hint: "Enter Photography name",
          ),
          MyTextField(
              fieldvalue: address,
              label: "Address",
              hint: "Enter Photography address"),
          MyTextField(
            fieldvalue: city,
            label: "City",
            hint: "Enter Photography City",
          ),
          MyTextField(
              fieldvalue: contact,
              label: "Contact",
              hint: "Enter Photography contact number"),
          MyTextField(
            fieldvalue: description,
            label: "Description",
            hint: "Enter Photography description",
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _availableFacilities.length,
            itemBuilder: (context, index) {
              final facility = _availableFacilities[index];
              return CheckboxListTile(
                title: Text(facility),
                value: (_facilities?.contains(facility) ?? false),
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
          TextButton(
            onPressed: () {
              _addPhotography(context, uid);
            },
            child: Text('Add Photography'),
          ),
        ],
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

  void _addPhotography(BuildContext context, String? uidvalue) async {
    if (name.text.isNotEmpty &&
        address.text.isNotEmpty &&
        city.text.isNotEmpty &&
        contact.text.isNotEmpty &&
        _facilities!.isNotEmpty &&
        selectedImages.isNotEmpty &&
        description.text.isNotEmpty) {
      await BlocProvider.of<PhotographyCubit>(context).addPhotography(PhotographyEntity(
        owner_id: uidvalue,
        images: selectedImages,
        name: name.text,
        city: city.text,
        address: address.text,
        contact: contact.text,
        facilities: _facilities,
        description: description.text,
      ));
    } else {
      DisplayToast("Enter Complete Information");
    }
  }
}
