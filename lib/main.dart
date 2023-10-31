import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:inux_barbershop/src/barbershop_app.dart';

Future<void> main() async {
  await initializeDateFormatting();
  runApp(const ProviderScope(child: BarbershopApp()));
}
