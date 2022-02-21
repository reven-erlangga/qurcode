import 'package:flutter/material.dart';
import 'package:qurcode/theme/theme.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height / 1.5,
      child: Center(
          child: Text(
        "Data is empty!",
        style: grayTextStyle.copyWith(fontSize: 16.0),
      )),
    );
  }
}
