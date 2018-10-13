import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.key, this.text, this.height, this.onPressed})
      : super(key: key);
  final Key key;
  final String text;
  final double height;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: BoxConstraints.expand(height: height),
      child: new RaisedButton(
          child: new Text(text,
              style: new TextStyle(
                  fontFamily: 'Ubuntu', color: Colors.white, fontSize: 21.0)),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(height / 2.1))),
          color: Colors.blue,
          textColor: Colors.black,
          onPressed: onPressed),
    );
  }
}
