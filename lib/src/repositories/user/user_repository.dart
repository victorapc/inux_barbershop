import 'package:inux_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:inux_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:inux_barbershop/src/core/fp/either.dart';
import 'package:inux_barbershop/src/core/fp/nil.dart';
import 'package:inux_barbershop/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();
  Future<Either<RepositoryException, Nil>> registerAdm(
      ({
        String name,
        String email,
        String password,
      }) userData);
}
