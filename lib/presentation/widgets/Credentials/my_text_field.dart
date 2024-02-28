import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    required this.fieldvalue,
    super.key,
    this.Isobscure,
    required this.label,
    required this.hint,
    this.readonly,
  });
  final TextEditingController fieldvalue;
  final bool? Isobscure;
  final String? label;
  final String? hint;
  final bool? readonly;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
      
        readOnly: widget.readonly ?? false,
        controller: widget.fieldvalue,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        obscureText: widget.Isobscure ?? false,
        decoration: InputDecoration(
          
          labelText: widget.label,
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            
            borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
