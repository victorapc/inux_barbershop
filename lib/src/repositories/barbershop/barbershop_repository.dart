import 'package:inux_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:inux_barbershop/src/core/fp/either.dart';
import 'package:inux_barbershop/src/model/barbershop_model.dart';
import 'package:inux_barbershop/src/model/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarberShop(
      UserModel userModel);
}
