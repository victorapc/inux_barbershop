import 'package:flutter/material.dart';
import 'package:inux_barbershop/src/core/ui/barbershop_icon.dart';
import 'package:inux_barbershop/src/core/ui/constants.dart';

class AvatarWidget extends StatelessWidget {
  final bool hideUploadButtom;
  const AvatarWidget({super.key, this.hideUploadButtom = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 102,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstants.avatar,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Offstage(
              // offstage se estiver true irá esconder o objeto.
              offstage: hideUploadButtom,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: ColorsConstants.brow,
                    width: 4,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  BarbershopIcons.addEmployee,
                  color: ColorsConstants.brow,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
