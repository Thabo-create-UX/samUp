import 'package:flutter/material.dart';

class RoomSearchField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const RoomSearchField({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        hintText: 'Search available blocks, rooms...',
        prefixIcon: Icon(Icons.search_rounded),
      ),
    );
  }
}
