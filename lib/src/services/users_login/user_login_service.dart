import 'package:inux_barbershop/src/core/fp/either.dart';
import 'package:inux_barbershop/src/core/fp/nil.dart';

abstract interface class UserLoginService {
  Future<Either<Exception, Nil>> execute(String email, String password);
}
