import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';
import '../blocs/image_picker/image_picker_bloc.dart';
import 'bottom_sheet_image_source.dart';
import 'rounded_button.dart';
import 'rounded_container.dart';

class CustomPhotoField extends StatefulWidget {
  final String bottomDescription;
  final Function(XFile? file) onPicked;
  final bool showDeleteButton;
  const CustomPhotoField({
    Key? key,
    required this.bottomDescription,
    required this.onPicked,
    this.showDeleteButton = false,
  }) : super(key: key);

  @override
  State<CustomPhotoField> createState() => _CustomPhotoFieldState();
}

class _CustomPhotoFieldState extends State<CustomPhotoField> {
  final _imagePicker = ImagePicker();
  final _bloc = ImagePickerBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedContainer(
            height: 46,
            color: AppColors.textFieldGrey,
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.small),
            child: Row(
              children: [
                AppHelpers.mediumHorizontalSpacing(),
                RoundedButton(
                  width: 90.0,
                  radius: 5.0,
                  color: Colors.white,
                  title: const Text(
                    'Pilih  Gambar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0,
                      color: Color(0xFF737373),
                    ),
                  ),
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (ctx) => BottomSheetImageSource(
                        selectCamera: () async {
                          Navigator.pop(context);
                          _bloc.add(PickingImage(
                            context: context,
                            imagePicker: _imagePicker,
                            imageSource: ImageSource.camera,
                          ));
                        },
                        selectGallery: () async {
                          Navigator.pop(context);
                          _bloc.add(PickingImage(
                            context: context,
                            imagePicker: _imagePicker,
                            imageSource: ImageSource.gallery,
                          ));
                        },
                      ),
                    );
                  },
                ),
                AppHelpers.smallHorizontalSpacing(),
                Expanded(
                  child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
                    listener: (context, state) {
                      if (state is ImagePickerLoaded) {
                        widget.onPicked(state.file);
                      } else {
                        widget.onPicked(null);
                      }
                    },
                    builder: (context, state) {
                      String? _fileName;
                      if (state is ImagePickerLoaded) {
                        _fileName = state.file?.name;
                      }
                      return Text(
                        _fileName ?? 'Tidak ada gambar yang dipilih',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0,
                          color: AppColors.textGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
                widget.showDeleteButton
                    ? IconButton(
                        splashRadius: 20.0,
                        padding: const EdgeInsets.all(0),
                        onPressed: () => _bloc.add(Clear()),
                        icon: SvgPicture.asset(
                          AppAssets.iconDelete,
                          width: 14.0,
                          height: 14.0,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Visibility(
            visible: widget.bottomDescription.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: AppDimensions.medium, top: AppDimensions.xSmall),
              child: Text(
                widget.bottomDescription,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.0,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
