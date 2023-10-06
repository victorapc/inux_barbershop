import 'package:flutter/material.dart';
import 'package:inux_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:inux_barbershop/src/core/ui/widgets/hours_painel.dart';
import 'package:inux_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends StatelessWidget {
  const BarbershopRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                onTapOutside: (_) => unfocus(context),
                textCapitalization: TextCapitalization.words,
                validator: Validatorless.required('Nome obrigatório'),
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => unfocus(context),
                validator: Validatorless.multiple([
                  Validatorless.required('E-mail obrigatório'),
                  Validatorless.email('E-mail inválido.'),
                ]),
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const WeekdaysPanel(),
              const SizedBox(
                height: 24,
              ),
              const HoursPainel(
                startTime: 6,
                endTime: 23,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () {},
                child: const Text('CADASTRAR ESTABELECIMENTO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
