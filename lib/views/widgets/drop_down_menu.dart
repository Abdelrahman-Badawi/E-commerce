import 'package:flutter/material.dart';

const List<String> list = <String>['S', 'M', 'L', 'XL', 'XXL'];

class DropDownMenuComponent extends StatelessWidget {
  const DropDownMenuComponent({
    super.key,
    required this.onSelected,
    required this.dropdownMenuEntries,
    required this.hintText
  });
  final void Function(String? value) onSelected;
  final List<String> dropdownMenuEntries;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: onSelected,
      hintText:hintText ,
      dropdownMenuEntries: dropdownMenuEntries
          .map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
    ;
  }
}
