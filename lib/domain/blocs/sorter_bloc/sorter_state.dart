import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SorterState extends Equatable {
  const SorterState();

  @override
  List<Object> get props => [];
}

class SorterInitial extends SorterState {}

class SorterLoaded extends SorterState {
  final File image;
  final String sortResult;

  SorterLoaded({this.image, this.sortResult});

  SorterLoaded copyWith({
    File image,
    String sortResult,
  }) {
    return SorterLoaded(
      image: image ?? this.image,
      sortResult: sortResult ?? this.sortResult,
    );
  }

  @override
  List<Object> get props => [image, sortResult];
}
