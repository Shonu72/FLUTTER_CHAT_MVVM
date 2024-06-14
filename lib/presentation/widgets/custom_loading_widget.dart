import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 120,
        width: 120,
        child: Image(image: AssetImage('assets/images/loading.gif'),));
  }
}
