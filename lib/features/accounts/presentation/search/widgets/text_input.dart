import 'package:flutter/material.dart';
import 'package:rentready_test/core/util/SizeConfig.dart';

InputDecoration buildTextInputDedcor() {
  return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        vertical: SizeConfig.h(2),
      ),
      border: const OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      prefixIcon: const Icon(
        Icons.search,
        color: Colors.white,
      ),
      hintText: "search..",
      hintStyle: TextStyle(color: Colors.white),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: SizeConfig.h(14),
      ),
      errorStyle: TextStyle(fontSize: SizeConfig.h(14)),
      fillColor: Colors.white70);
}
