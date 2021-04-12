import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_sorter/domain/blocs/sorter_bloc/bloc.dart';

class SorterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Sorter')),
        body: _body(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _pickImageButton(
              context,
              icon: Icons.camera_alt,
              imageSource: ImageSource.camera,
            ),
            SizedBox(width: 20),
            _pickImageButton(
              context,
              icon: Icons.image,
              imageSource: ImageSource.gallery,
            ),
          ],
        ),
      );

  Widget _body() => BlocBuilder<SorterBloc, SorterState>(
        builder: (context, state) {
          if (state is SorterLoaded && state.image != null) {
            return buildUI(context, state);
          }
          return Container();
        },
      );

  Widget buildUI(BuildContext context, SorterLoaded state) =>
      SingleChildScrollView(
        child: Column(
          children: [
            Image.file(state.image),
            SizedBox(height: 50),
            Text(state.sortResult),
            SizedBox(height: 100),
          ],
        ),
      );

  Widget _pickImageButton(
    BuildContext context, {
    IconData icon,
    ImageSource imageSource,
  }) =>
      FloatingActionButton(
        onPressed: () => _classifyImage(context, imageSource: imageSource),
        child: Icon(icon),
      );

  void _classifyImage(BuildContext context, {ImageSource imageSource}) {
    BlocProvider.of<SorterBloc>(context).add(
      ClassifyImage(imageSource: imageSource),
    );
  }
}
