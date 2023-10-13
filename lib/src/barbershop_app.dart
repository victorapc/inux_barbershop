import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter/material.dart';
import 'package:inux_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:inux_barbershop/src/features/auth/login/login_page.dart';
import 'package:inux_barbershop/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:inux_barbershop/src/features/auth/register/user/user_register_page.dart';
import 'package:inux_barbershop/src/features/home/adm/home_adm_page.dart';
import 'package:inux_barbershop/src/features/splash/splash_page.dart';

import 'core/ui/barbersshop_theme.dart';
import 'core/ui/widgets/barbershop_loader.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'BarberShop',
          theme: BarbersshopTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbershopNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
            '/home/adm': (_) => const HomeAdmPage(),
            '/home/employee': (_) => const Text('Employee'),
          },
        );
      },
    );
  }
}
