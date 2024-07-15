import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/widgets/w_scale.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? buttonColor;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final Widget? child;
  final BoxBorder? border;
  final bool loading;
  final bool disabled;
  final double? borderRadius;
  final Color disabledColor;
  final Color? borderColor;

  const WButton({
    required this.onTap,
    this.buttonColor,
    this.width,
    this.borderRadius,
    this.height,
    this.text = '',
    this.color,
    this.textColor,
    this.textStyle,
    this.margin,
    this.padding,
    this.border,
    this.loading = false,
    this.disabled = false,
    this.disabledColor = Colors.grey,
    this.borderColor,
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: WScaleAnimation(
          onTap: () {
            if (!(loading || disabled)) {
              onTap();
            }
          },
          isDisabled: disabled,
          child: Container(
            width: width,
            height: height,
            padding: padding ?? EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: disabled ? disabledColor : color ?? context.colors.white,
              borderRadius: BorderRadius.circular(borderRadius ?? 30),
              border: border,
            ),
            child: loading
                ? const Center(child: CupertinoActivityIndicator())
                : Align(
                    alignment: Alignment.center,
                    child: child ??
                        Text(
                          text,
                          style: textStyle ??
                              context.style.fontSize16Weight500.copyWith(
                                color: context.colors.mainRadishColor,
                                decorationColor: context.colors.mainRadishColor
                                    .withOpacity(0.5),
                              ),
                        ),
                  ),
          ),
        ),
      );
}
