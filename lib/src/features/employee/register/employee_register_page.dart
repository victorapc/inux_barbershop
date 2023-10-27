import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inux_barbershop/src/core/providers/application_providers.dart';
import 'package:inux_barbershop/src/core/ui/helpers/messages.dart';
import 'package:inux_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:inux_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:inux_barbershop/src/core/ui/widgets/hours_painel.dart';
import 'package:inux_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:inux_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:inux_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:inux_barbershop/src/model/barbershop_model.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerADM = false;
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarberShopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador cadastrado com sucesso.', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador.', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: barbershopAsyncValue.when(
        error: (error, stackTrace) {
          log('Erro ao carregar a página',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar a página.'),
          );
        },
        loading: () => const BarbershopLoader(),
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      const AvatarWidget(),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: registerADM,
                            onChanged: (value) {
                              setState(() {
                                registerADM = !registerADM;
                                employeeRegisterVm.setRegisterADM(registerADM);
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'Sou administrador e quero me cadastrar como colaborador',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Offstage tem a mesma ideia do View.Gone do Android.
                      Offstage(
                        offstage: registerADM,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameEC,
                              validator: registerADM
                                  ? null
                                  : Validatorless.required('Nome obrigatório.'),
                              decoration: const InputDecoration(
                                label: Text('Nome'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _emailEC,
                              validator: registerADM
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'E-mail obrigatório.'),
                                      Validatorless.email('E-mail inválido.'),
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('E-mail'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordEC,
                              validator: registerADM
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'Senha obrigatória.'),
                                      Validatorless.min(6,
                                          'A senha deve conter no mínimo 6 caracters.'),
                                    ]),
                              obscureText: true,
                              decoration: const InputDecoration(
                                label: Text('Senha'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      WeekdaysPanel(
                        enableDays: openingDays,
                        onDayPressed: employeeRegisterVm.addOrRemoveWorkDays,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      HoursPainel(
                        startTime: 6,
                        endTime: 23,
                        onHourPressed: employeeRegisterVm.addOrRemoveWorkHours,
                        enableTimes: openingHours,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () {
                          switch (_formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError(
                                  'Existem campos inválidos.', context);
                            case true:
                              final EmployeeRegisterState(
                                workDays: List(isNotEmpty: hasWorkDays),
                                workHours: List(isNotEmpty: hasWorkHours),
                              ) = ref.watch(employeeRegisterVmProvider);

                              if (!hasWorkDays || !hasWorkHours) {
                                Messages.showError(
                                    'Por favor selecione os dias da semana e horário de atendimento.',
                                    context);
                                return;
                              }

                              final name = _nameEC.text;
                              final email = _emailEC.text;
                              final password = _passwordEC.text;

                              employeeRegisterVm.register(
                                name: name,
                                email: email,
                                password: password,
                              );
                          }
                        },
                        child: const Text('CADASTRAR COLABORADOR'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
