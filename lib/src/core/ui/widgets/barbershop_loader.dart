import 'package:flutter/material.dart';
import 'package:inux_barbershop/src/core/ui/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BarbershopLoader extends StatelessWidget {
  const BarbershopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: ColorsConstants.brow,
        size: 80,
      ),
    );
  }
}
