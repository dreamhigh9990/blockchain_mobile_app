// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CountryDropDownWidget extends StatefulWidget {
    final List<String> countryNames;
  const CountryDropDownWidget({
    Key? key,
    required this.countryNames,
  }) : super(key: key);

  @override
  State<CountryDropDownWidget> createState() => _CountryDropDownWidgetState();
}

class _CountryDropDownWidgetState extends State<CountryDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownSearch<String>(
        // ignore: prefer_const_constructors
        popupProps: PopupProps.menu(
          showSearchBox: true,
          showSelectedItems: true,
          // disabledItemFn: (String s) => s.startsWith('I'),
        ),
        items: widget.countryNames, // Use the countryNames from the widget
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            fillColor: const Color(0xff181328), // Fill color
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.black, // Border color
              ),
            ),
            labelText: "Menu mode",
            hintText: "country in menu mode",
          ),
        ),
        onChanged: print,
        selectedItem: "Brazil",
      ),
    );
  }
}
