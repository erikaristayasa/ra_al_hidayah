part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class PickingImage extends ImagePickerEvent {
  final BuildContext context;
  final ImagePicker imagePicker;
  final ImageSource imageSource;

  const PickingImage({
    required this.context,
    required this.imagePicker,
    required this.imageSource,
  });

  @override
  List<Object> get props => [
        context,
        imagePicker,
        imageSource,
      ];
}

class Clear extends ImagePickerEvent {}
