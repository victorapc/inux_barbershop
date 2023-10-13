import 'package:flutter/material.dart';
import 'package:inux_barbershop/src/core/ui/barbershop_icon.dart';
import 'package:inux_barbershop/src/core/ui/constants.dart';
import 'package:inux_barbershop/src/features/home/adm/widget/home_employee_tile.dart';
import 'package:inux_barbershop/src/features/home/widget/home_header.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            BarbershopIcons.addEmployee,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const HomeEmployeeTile(),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
