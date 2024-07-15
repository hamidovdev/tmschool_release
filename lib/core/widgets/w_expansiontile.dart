import 'package:flutter/material.dart';
import 'package:tm_school/core/extensions/extension.dart';

class WExpansionTile extends StatefulWidget {
  final String title;
  final bool? maintainState;
  final Color? borderColor;
  final double? borderRadius;
  final Alignment? alignment;
  final double? childrenPadding;
  final Color? collapsedBackgroundColor;
  final bool? dense;
  final Color? borderAll;
  final List<Widget>? children;
  final Function(bool)? onExpansionChanged;
  final ExpansionTileController? controller;
  final ListTileControlAffinity? controlAffinity;

  const WExpansionTile({
    super.key,
    required this.title,
    this.maintainState,
    this.borderColor,
    this.borderRadius,
    this.alignment,
    this.childrenPadding,
    this.collapsedBackgroundColor,
    this.dense,
    this.children,
    this.borderAll,
    this.onExpansionChanged,
    this.controller, this.controlAffinity,
  });

  @override
  _WTextFieldState createState() {
    return _WTextFieldState();
  }
}

class _WTextFieldState extends State<WExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controlAffinity: widget.controlAffinity,
      controller: widget.controller,
      onExpansionChanged: widget.onExpansionChanged,
      collapsedShape: Border.all(
        color: widget.borderAll ?? context.colors.orange,
      ),
      title: Text(
        widget.title,
        style: context.style.fontSize13Weight300.copyWith(
          color: context.colors.hintTextColor,
        ),
      ),
      maintainState: widget.maintainState ?? true,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: widget.borderColor ?? context.colors.orange,
        ),
        borderRadius: BorderRadius.circular(
          widget.borderRadius ?? 2,
        ),
      ),
      expandedAlignment: widget.alignment ?? Alignment.center,
      childrenPadding: EdgeInsets.all(widget.childrenPadding ?? 20),
      collapsedBackgroundColor:
          widget.collapsedBackgroundColor ?? context.colors.textFieldBackground,
      dense: widget.dense ?? true,
      children: widget.children ?? [],
    );
  }
}
