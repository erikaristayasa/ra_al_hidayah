import 'package:flutter/material.dart';

import '../../../statics/statics.dart';

class CustomDropDown extends StatefulWidget {
  final List<dynamic> items;
  final String? hint;
  final Function(dynamic value) onChanged;
  final dynamic initialValue;
  const CustomDropDown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.hint,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  dynamic _selectedValue;
  final InputBorder inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  void initState() {
    _selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.xSmall),
      child: DropdownButtonFormField<dynamic>(
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: AppColors.textGrey,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textGrey,
            fontSize: 12.0,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: InputBorder.none,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          fillColor: AppColors.textFieldGrey,
        ),
        value: _selectedValue,
        items: List<DropdownMenuItem<dynamic>>.from(
          widget.items.map(
            (e) => DropdownMenuItem<dynamic>(
              value: e,
              child: Text(
                e.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
