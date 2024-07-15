import 'package:flutter/material.dart';
import 'package:tm_school/core/extensions/extension.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Tez kunda",
          style: context.style.fontSize24Weight700.copyWith(
            color: context.colors.mainRadishColor,
          ),
        ),
      ),
    );
  }
}
