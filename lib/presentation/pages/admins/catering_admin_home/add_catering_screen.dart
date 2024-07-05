import 'dart:io';
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:evemanager/presentation/widgets/Credentials/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddCateringScreen extends StatefulWidget {
  const AddCateringScreen({
    required this.uid,
    super.key,
  });
  final String uid;

  @override
  State<AddCateringScreen> createState() => _AddCateringScreenState();
}

class _AddCateringScreenState extends State<AddCateringScreen> {
  List<File> selectedImages = [];

  List<String> _availableFacilities = [
    'Buffet',
    'Plated',
    'Family Style',
    'Cocktail Reception',
    'Food Stations',
    'Dessert Table',
  ];
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController description = TextEditingController();
  List<String>? _facilities = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CateringserviceCubit, CateringserviceState>(
        listener: (context, state) {
      if (name.text.isNotEmpty) {
        if (state is CateringserviceSuccessForOwner) {
          DisplayToast('Catering Added Successfully');
          Navigator.pop(context);
        } else if (state is CateringserviceFailure) {
          DisplayToast('Some Failure Occurred');
        }
      }
    }, builder: (BuildContext context, CateringserviceState state) {
      if (state is CateringserviceLoading) {
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
        title: Text('Add Catering'),
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
            hint: "Enter Catering name",
          ),
          MyTextField(
              fieldvalue: address,
              label: "Address",
              hint: "Enter Catering address"),
          MyTextField(
            fieldvalue: city,
            label: "City",
            hint: "Enter Catering City",
          ),
          MyTextField(
              fieldvalue: contact,
              label: "contact",
              hint: "Enter Catering contact number"),
          MyTextField(
            fieldvalue: description,
            label: "Description",
            hint: "Enter Catering dscription",
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
              _addCatering(context, uid);
            },
            child: Text('Add Catering'),
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

  void _addCatering(BuildContext context, String? uidvalue) async {
    if (name.text.isNotEmpty &&
        address.text.isNotEmpty &&
        city.text.isNotEmpty &&
        contact.text.isNotEmpty &&
        _facilities!.isNotEmpty &&
        selectedImages.isNotEmpty &&
        description.text.isNotEmpty) {
      await BlocProvider.of<CateringserviceCubit>(context)
          .AddCateringService(CateringEntity(
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
