import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final double padding;
  final String label;
  const PasswordInput(
      {this.padding = 10,
      required this.controller,
      this.label = "Password",
      Key? key})
      : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.padding),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.label,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
          isDense: true,
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
        validator: (val) => val!.length < 6 ? 'Password too short.' : null,
        onSaved: (val) => print(val),
        obscureText: _isObscure,
      ),
    );
  }
}
