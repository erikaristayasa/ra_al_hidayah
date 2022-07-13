import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/statics.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String? keyword) onSubmit;
  const CustomSearchBar({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _controller = TextEditingController();

  search() {
    final _keyword = _controller.text;
    widget.onSubmit(_keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      padding: const EdgeInsets.only(left: AppDimensions.medium),
      decoration: BoxDecoration(
        color: AppColors.textFieldGrey,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: widget.onSubmit,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 11.0),
          border: InputBorder.none,
          hintText: 'Cari',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
            color: AppColors.textGrey,
          ),
          suffixIcon: IconButton(
            padding: const EdgeInsets.all(0.0),
            splashRadius: 10.0,
            onPressed: search,
            icon: SvgPicture.asset(
              AppAssets.iconSearch,
              width: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
