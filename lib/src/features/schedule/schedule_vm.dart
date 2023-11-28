import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:intl/intl.dart';
import 'package:inux_barbershop/src/core/fp/either.dart';
import 'package:inux_barbershop/src/core/providers/application_providers.dart';
import 'package:inux_barbershop/src/features/schedule/schedule_state.dart';
import 'package:inux_barbershop/src/model/barbershop_model.dart';
import 'package:inux_barbershop/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelect(int hour) {
    if (hour == state.scheduleHour) {
      state = state.copyWith(
        scheduleHour: () => null,
      );
    } else {
      state = state.copyWith(
        scheduleHour: () => hour,
      );
    }
  }

  void dataSelect(DateTime date) {
    state = state.copyWith(
      scheduleDate: () => date,
    );
  }

  Future<void> register(
      {required UserModel userModel, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduleHour) = state;
    final scheduleRepository = ref.read(scheduleRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.watch(getMyBarberShopProvider.future);

    String formattedDateString = DateFormat('yyyy-MM-dd').format(scheduleDate!);
    DateTime convertedDateTime =
        DateFormat('yyyy-MM-dd').parse(formattedDateString);

    final dto = (
      barbershopId: barbershopId,
      userId: userModel.id,
      clientName: clientName,
      date: convertedDateTime,
      time: scheduleHour!
    );

    final scheduleResult = await scheduleRepository.scheduleClient(dto);

    switch (scheduleResult) {
      case Success():
        state = state.copyWith(status: ScheduleStateStatus.success);
      case Failure():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
