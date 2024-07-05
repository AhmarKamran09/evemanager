import 'dart:io';

import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/presentation/cubit/decoration/decoration_cubit.dart';
import 'package:evemanager/presentation/widgets/Credentials/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddDecorationScreen extends StatefulWidget {
  const AddDecorationScreen({
    required this.uid,
    super.key,
  });
  final String uid;

  @override
  State<AddDecorationScreen> createState() => _AddDecorationScreenState();
}

class _AddDecorationScreenState extends State<AddDecorationScreen> {
  List<File> selectedImages = [];

  List<String> _availableFacilities = [
    'Lighting',
    'Floral Arrangements',
    'Themed Decorations',
    'Drapery',
    'Furniture',
    'Props',
  ];
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController description = TextEditingController();
  List<String>? _facilities = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DecorationCubit, DecorationState>(listener: (context, state) {
      if (name.text.isNotEmpty) {
        if (state is DecorationsSuccessForOwner) {
          DisplayToast('Decoration Added Successfully');
          Navigator.pop(context);
        } else if (state is DecorationsFailure) {
          DisplayToast('Some Failure Occurred');
        }
      }
    }, builder: (BuildContext context, DecorationState state) {
      if (state is DecorationsLoading) {
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
        title: Text('Add Decoration'),
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
            hint: "Enter Decoration name",
          ),
          MyTextField(
              fieldvalue: address,
              label: "Address",
              hint: "Enter Decoration address"),
          MyTextField(
            fieldvalue: city,
            label: "City",
            hint: "Enter Decoration City",
          ),
          MyTextField(
              fieldvalue: contact,
              label: "Contact",
              hint: "Enter Decoration contact number"),
          MyTextField(
            fieldvalue: description,
            label: "Description",
            hint: "Enter Decoration description",
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
              _addDecoration(context, uid);
            },
            child: Text('Add Decoration'),
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

  void _addDecoration(BuildContext context, String? uidvalue) async {
    if (name.text.isNotEmpty &&
        address.text.isNotEmpty &&
        city.text.isNotEmpty &&
        contact.text.isNotEmpty &&
        _facilities!.isNotEmpty &&
        selectedImages.isNotEmpty &&
        description.text.isNotEmpty) {
      await BlocProvider.of<DecorationCubit>(context).AddDecorations(DecorationsEntity(
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
