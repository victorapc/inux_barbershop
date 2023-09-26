import 'package:inux_barbershop/src/core/exceptions/service_exception.dart';
import 'package:inux_barbershop/src/core/fp/either.dart';
import 'package:inux_barbershop/src/core/fp/nil.dart';

abstract interface class UserRegisterService {
  Future<Either<ServiceException, Nil>> execute(
      ({
        String name,
        String email,
        String password,
      }) userData);
}
