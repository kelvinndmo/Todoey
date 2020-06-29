import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const kPrimaryColor = Color(0xFF16171B);
const kDarkInputDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);

const kDarkBoxShadow = [
  BoxShadow(
      color: Colors.black,
      blurRadius: 2.0,
      spreadRadius: 4.0,
      offset: Offset(2.0, 2))
];
