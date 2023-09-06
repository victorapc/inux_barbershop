import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inux_barbershop/src/barbershop_app.dart';

void main() {
  runApp(const ProviderScope(child: BarbershopApp()));
}
