import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/shared/presentation/blocs/image_picker/image_picker_bloc.dart';
import '../../../../core/shared/presentation/widgets/bottom_sheet_image_source.dart';
import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';

class ImageProfilePicker extends StatefulWidget {
  final String url;
  final Function(XFile? file) onPicked;
  const ImageProfilePicker({Key? key, required this.url, required this.onPicked}) : super(key: key);

  @override
  State<ImageProfilePicker> createState() => _ImageProfilePickerState();
}

class _ImageProfilePickerState extends State<ImageProfilePicker> {
  final _imagePicker = ImagePicker();
  final _bloc = ImagePickerBloc();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<ImagePickerBloc, ImagePickerState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ImagePickerLoaded) {
              widget.onPicked(state.file);
              return CircleAvatar(
                radius: 55,
                foregroundImage: FileImage(File(state.file!.path)),
              );
            } else {
              widget.onPicked(null);
              return CircleAvatar(
                radius: 55,
                foregroundImage: NetworkImage(widget.url),
              );
            }
          },
        ),
        InkWell(
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
          child: SizedBox(
            height: 110,
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                RoundedContainer(
                  padding: EdgeInsets.all(0),
                  color: AppColors.primary,
                  height: 26.0,
                  width: 26.0,
                  radius: 13.0,
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
