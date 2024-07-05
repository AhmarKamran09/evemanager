import 'dart:io';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/presentation/cubit/sweets/sweets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateSweetsScreen extends StatefulWidget {
  UpdateSweetsScreen({super.key, required this.sweetsEntity});
  final SweetEntity sweetsEntity;

  @override
  State<UpdateSweetsScreen> createState() => _UpdateSweetsScreenState();
}

class _UpdateSweetsScreenState extends State<UpdateSweetsScreen> {
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String>? _facilities = [];

  List<File> selectedImages = [];

  List<String> _availableServices = [
    'Cakes',
    'Cupcakes',
    'Cookies',
    'Pastries',
    'Dessert Tables',
    'Custom Orders',
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < (widget.sweetsEntity.facilities?.length ?? 0); i++) {
      if (!_facilities!.contains(widget.sweetsEntity.facilities![i])) {
        _facilities?.add(widget.sweetsEntity.facilities![i]);
      }
    }

    contactController.text = widget.sweetsEntity.contact ?? '';
    descriptionController.text = widget.sweetsEntity.description ?? '';
    cityController.text = widget.sweetsEntity.city ?? '';
    addressController.text = widget.sweetsEntity.address ?? '';

    return BlocConsumer<SweetsCubit, SweetsState>(
      listener: (context, state) {
        if (state is SweetsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Updated Successfully. Refresh to see updates'),
          ));
          Navigator.pop(context);
        } else if (state is SweetsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Some failure occurred'),
          ));
        }
      },
      builder: (BuildContext context, SweetsState state) {
        if (state is SweetsLoading) {
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
        title: Text('Update Sweets'),
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
                      : widget.sweetsEntity.images!.length,
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
                              widget.sweetsEntity.images![index],
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
              widget.sweetsEntity.name!,
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
                        if (widget.sweetsEntity.facilities!.contains(service)) {
                          widget.sweetsEntity.facilities!
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
                  _updateSweets(context);
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

  Future<void> _updateSweets(BuildContext context) async {
    if (selectedImages.isEmpty) {
      selectedImages = widget.sweetsEntity.images!;
    }

    await BlocProvider.of<SweetsCubit>(context).updateSweets(SweetEntity(
      city: cityController.text,
      address: addressController.text,
      id: widget.sweetsEntity.id,
      description: descriptionController.text,
      contact: contactController.text,
      facilities: _facilities,
      images: selectedImages,
    ));
    _facilities = [];
  }
}
