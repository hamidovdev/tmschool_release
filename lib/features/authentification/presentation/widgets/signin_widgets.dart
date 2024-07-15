
import 'package:flutter/material.dart';
import 'package:tm_school/core/extensions/extension.dart';

class GetTextFunc extends StatelessWidget {
  final String text;

  const GetTextFunc({
    super.key,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: context.style.fontSize13Weight300,
      ),
    );
  }
}

class GetTextFunc2 extends StatelessWidget {
  final String text;

  const GetTextFunc2({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 15,
        bottom: 10,
      ),
      child: Text(
        text,
        style: context.style.fontSize18Weight400,
      ),
    );
  }
}
