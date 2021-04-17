import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_sorter/domain/blocs/sorter_bloc/bloc.dart';
import 'package:waste_sorter/presentation/widgets/ws_button.dart';

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
              title: 'From camera',
              imageSource: ImageSource.camera,
            ),
            SizedBox(width: 20),
            _pickImageButton(
              context,
              title: 'From gallery',
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
    String title,
    ImageSource imageSource,
  }) =>
      Padding(
        padding: EdgeInsets.all(10),
        child: WSButton(
          onPressed: () => _classifyImage(context, imageSource: imageSource),
          title: title,
        ),
      );

  void _classifyImage(BuildContext context, {ImageSource imageSource}) {
    BlocProvider.of<SorterBloc>(context).add(
      ClassifyImage(imageSource: imageSource),
    );
  }
}
