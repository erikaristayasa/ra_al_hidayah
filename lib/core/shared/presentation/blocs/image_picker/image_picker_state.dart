part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object?> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerLoaded extends ImagePickerState {
  final XFile? file;

  const ImagePickerLoaded({
    this.file,
  });

  @override
  List<Object?> get props => [file];
}

class ImagePickerError extends ImagePickerState {
  final dynamic error;

  const ImagePickerError({this.error});

  @override
  List<Object?> get props => [error];
}
