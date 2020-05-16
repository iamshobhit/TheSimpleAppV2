import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'the',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
        TextSpan(text: 'SimpleApp', style: TextStyle(color: Colors.black45)),
        TextSpan(
            text: 'v2',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w300)),
      ],
    ),
  );
}

Widget blueButton(BuildContext context, String label) {
  return Container(
    child: Text(label),
    height: 40,
    decoration: BoxDecoration(
      color: Colors.teal,
      borderRadius: BorderRadius.circular(20),
    ),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
  );
}

Widget createButton(BuildContext context, String label) {
  return Container(
    child: Text(label),
    height: 40,
    decoration: BoxDecoration(
      color: Colors.teal,
      borderRadius: BorderRadius.circular(20),
    ),
    alignment: Alignment.center,
    width: 160,
  );
}

Widget passPadding(BuildContext context,String label) {
  return Container(
    child: Container(
      child: Text(
        (label),
        textAlign: TextAlign.center,
        textScaleFactor: 1.5,
      ),
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.tealAccent,
    ),
  );
}

