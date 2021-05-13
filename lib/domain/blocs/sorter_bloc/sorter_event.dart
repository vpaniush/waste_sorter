import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

abstract class SorterEvent extends Equatable {
  const SorterEvent();

  @override
  List<Object> get props => [];
}

class LoadSorter extends SorterEvent {}

class ClassifyImage extends SorterEvent {
  final ImageSource imageSource;

  ClassifyImage({@required this.imageSource});

  @override
  List<Object> get props => [imageSource];
}
