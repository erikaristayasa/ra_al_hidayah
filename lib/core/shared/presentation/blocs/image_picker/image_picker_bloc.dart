import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickingImage>((event, emit) async {
      try {
        XFile? _file = await event.imagePicker.pickImage(source: event.imageSource);
        emit(ImagePickerLoaded(file: _file));
      } catch (e) {
        emit(ImagePickerError(error: e));
      }
    });

    on<Clear>((event, emit) => emit(ImagePickerInitial()));
  }
}
