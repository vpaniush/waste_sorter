import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_sorter/domain/blocs/sorter_bloc/bloc.dart';
import 'package:waste_sorter/presentation/widgets/ws_app_bar.dart';
import 'package:waste_sorter/presentation/widgets/ws_button.dart';

class SorterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: WsAppBar.build(title: 'Sort waste'),
        body: _body(),
      );

  Widget _body() => BlocBuilder<SorterBloc, SorterState>(
        builder: (context, state) {
          if (state is SorterLoaded) {
            return buildUI(context, state);
          }
          return Container();
        },
      );

  Widget buildUI(BuildContext context, SorterLoaded state) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imagePickers(context),
            if (state.image != null) ...[
              SizedBox(height: 20.h),
              _sortResult(state),
              SizedBox(height: 20.h),
              Image.file(state.image),
              SizedBox(height: 20.h),
            ],
          ],
        ),
      );

  Widget _imagePickers(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _pickImageButton(
            context,
            title: 'From camera',
            imageSource: ImageSource.camera,
          ),
          SizedBox(width: 20.w),
          _pickImageButton(
            context,
            title: 'From gallery',
            imageSource: ImageSource.gallery,
          ),
        ],
      );

  Widget _sortResult(SorterLoaded state) => Text(
        state.sortResult.toUpperCase(),
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
      );

  Widget _pickImageButton(
    BuildContext context, {
    String title,
    ImageSource imageSource,
  }) =>
      Padding(
        padding: EdgeInsets.all(10.r),
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
