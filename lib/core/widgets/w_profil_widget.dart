import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';

class WProfileWidget extends StatefulWidget {
  final String icon;
  final String text;
  final bool wider;
  final TextStyle? sytle;

  const WProfileWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.wider,
    this.sytle,
  }) : super(key: key);
  @override
  _WProfileWidget createState() {
    return _WProfileWidget();
  }
}

class _WProfileWidget extends State<WProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(widget.icon),
        const Gap(20),
        Text(
          widget.text,
          style: widget.sytle ?? context.style.fontSize18Weight500,
        ),
        const Spacer(),
        if (widget.wider == true) SvgPicture.asset(context.icon.wider)
      ],
    );
  }
}
