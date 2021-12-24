import 'package:flutter/material.dart';
import 'package:rentready_test/core/util/SizeConfig.dart';

Future showFilterSheet(BuildContext context, bool isActive, String? address) {
  return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      // enableDrag: false,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      builder: (_) => Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0))),
            height: SizeConfig.h(400),
            child: FilterSheet(
              isActive: isActive,
              address: address,
            ),
          ));
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key, required this.isActive, this.address})
      : super(key: key);
  final bool isActive;
  final String? address;
  @override
  _FilterSheetState createState() => _FilterSheetState(isActive, address);
}

class _FilterSheetState extends State<FilterSheet> {
  _FilterSheetState(this.isActive, this.address);
  bool isActive;
  String? address;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Filter",
                style: TextStyle(
                    fontSize: SizeConfig.h(25), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.h(15),
          ),
          SizedBox(
              width: SizeConfig.w(350),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    address = v;
                  });
                },
                decoration: buildAddressTextInputDedcor(),
                style: const TextStyle(color: Colors.white),
              )),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.w(300),
                child: SwitchListTile(
                  value: isActive,
                  onChanged: (v) {
                    setState(() {
                      isActive = v;
                    });
                  },
                  title: Text("is Account Active:"),
                ),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.h(15),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context, {"isActive": isActive, "address": address});
              },
              child: Text("Apply Filter"))
        ],
      ),
    );
  }
}

InputDecoration buildAddressTextInputDedcor() {
  return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        vertical: SizeConfig.h(2),
      ),
      border: const OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      prefixIcon: const Icon(
        Icons.location_on,
        color: Colors.black,
      ),
      labelText: "Address",
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: SizeConfig.h(14),
      ),
      errorStyle: TextStyle(fontSize: SizeConfig.h(14)),
      fillColor: Colors.white70);
}
