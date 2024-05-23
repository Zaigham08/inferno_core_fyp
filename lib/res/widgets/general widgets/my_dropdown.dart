import 'package:flutter/material.dart';

import '../../constants.dart';
import 'my_text.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items;
  final String value, title;
  final ValueChanged<String?> onChanged;

  const MyDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " ${widget.title}",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: txtColor, // Adjust the text color
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white, // Adjust the background color
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1.5,
                blurRadius: 3,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isDense: true,
              value: selectedValue,
              onChanged: (val) {
                widget.onChanged(val);
                setState(() {
                  selectedValue = val!;
                });
              },
              dropdownColor: Colors.grey,
              iconEnabledColor: Colors.black,
              items: widget.items.map((name) {
                return DropdownMenuItem<String>(
                  value: name,
                  child: SizedBox(
                    width: 255,
                    child: MyText(
                      name,
                      maxLines: 1,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
