import 'dart:io';

import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/presentation/cubit/marriagehall/marriage_hall_cubit.dart';
import 'package:evemanager/presentation/widgets/Credentials/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddMarriageHalls extends StatefulWidget {
  const AddMarriageHalls({
    required this.uid,
    super.key,
  });
  final String uid;

  @override
  State<AddMarriageHalls> createState() => _AddMarriageHallsState();
}

class _AddMarriageHallsState extends State<AddMarriageHalls> {
  List<File> selectedImages = [];

  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController capacity = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController facilities = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarriageHallCubit, MarriageHallState>(
        listener: (context, state) {
      if (name.text.isNotEmpty) {
        if (state is MarriageHallSuccessForOwner) {
        // if (state is MarriageHallSuccess) {
          DisplayToast('Marriage Hall Added Successfully');
          Navigator.pop(context);
        } else if (state is MarriageHallFailure) {
          DisplayToast('Some Failure Occurred');
        }
      }
    }, builder: (BuildContext context, MarriageHallState state) {
      if (state is MarriageHallLoading) {
        return Stack(
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
        );
      } else
        return _body(context, widget.uid);
    });
  }

  Scaffold _body(BuildContext context, String uid) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Marriage Hall'),
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
            hint: "Enter Hall name",
          ),
          MyTextField(
              fieldvalue: address,
              label: "Address",
              hint: "Enter Hall address"),
          MyTextField(
              fieldvalue: capacity,
              label: "Capacity",
              hint: "Enter hall capacity"),
          MyTextField(
              fieldvalue: contact,
              label: "contact",
              hint: "Enter hall contact number"),
          MyTextField(
              fieldvalue: facilities,
              label: "Facilities",
              hint: "Enter hall Facilities"),
          MyTextField(
            fieldvalue: description,
            label: "Description",
            hint: "Enter hall dscription",
          ),
          TextButton(
            onPressed: () {
              _addmarriagehall(context, uid);
            },
            child: Text('Add Mariage Hall'),
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

  void _addmarriagehall(BuildContext context, String? uidvalue) async {
    if (name.text.isNotEmpty &&
        address.text.isNotEmpty &&
        capacity.text.isNotEmpty &&
        contact.text.isNotEmpty &&
        facilities.text.isNotEmpty &&
        selectedImages.isNotEmpty &&
        description.text.isNotEmpty) {
      await BlocProvider.of<MarriageHallCubit>(context)
          .AddMarriageHall(MarriageHallEntity(
        owner_id: uidvalue,
        images: selectedImages,
        name: name.text,
        address: address.text,
        capacity: int.parse(capacity.text),
        contact: contact.text,
        facilities: [facilities.text],
        description: description.text,
      ));
    } else {
      DisplayToast("Enter Complete Information");
    }
  }
}
