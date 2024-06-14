import 'package:charterer/core/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class NoDataFoundWidget extends StatelessWidget {
  final String? text;
  const NoDataFoundWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = ApplicationTheme.getAppThemeData().textTheme;

    return Center(
        child: Text(
      text ?? 'Please Search...',
      textAlign: TextAlign.center,
      style: textTheme.headlineSmall?.copyWith(color: textBlackColor),
    ));
  }
}
