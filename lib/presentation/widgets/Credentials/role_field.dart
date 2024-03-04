import 'package:flutter/material.dart';

class RoleField extends StatefulWidget {
  final TextEditingController fieldvalue;
  RoleField({super.key, required this.fieldvalue});

  @override
  State<RoleField> createState() => _RoleFieldState();
}

class _RoleFieldState extends State<RoleField> {
  List dropDownListData = [
    {"title": "Client", "value": "1"},
    {"title": "Decoration", "value": "2"},
    {"title": "Venue", "value": "3"},
    {"title": "Transportation", "value": "4"},
    {"title": "Catering", "value": "5"},
    {"title": "Photography", "value": "6"},
    {"title": "Entertainment (Music and Speakers)", "value": "7"},
    {"title": "Bridal Makeup & Hair", "value": "8"},
    {"title": "Invitation Design", "value": "9"},
    {"title": "Clothing", "value": "10"},
    {"title": "Sweets", "value": "11"},
    {"title": "Videography", "value": "12"},
  ];

  String? selectedrole = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          InputDecorator(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              contentPadding: const EdgeInsets.all(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedrole,
                isDense: true,
                // isExpanded: true,
                menuMaxHeight: 350,
                items: [
                  const DropdownMenuItem(
                      child: Text(
                        "Select Role",
                      ),
                      value: ""),
                  ...dropDownListData.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                        child: Text(e['title']), value: e['value']);
                  }).toList(),
                ],
                onChanged: (newValue) {
                  setState(
                    () {
                      selectedrole = newValue!;
                      widget.fieldvalue.text = selectedrole!;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
