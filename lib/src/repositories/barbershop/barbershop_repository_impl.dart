import 'package:dio/dio.dart';
import 'package:inux_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:inux_barbershop/src/core/fp/either.dart';
import 'package:inux_barbershop/src/core/restclient/rest_client.dart';
import 'package:inux_barbershop/src/model/barbershop_model.dart';
import 'package:inux_barbershop/src/model/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarberShop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        // Outra forma de colocar a data no fromMap é data.first no caso de list,
        // que substitui data: List(first: data) do Response.
        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) =
            await restClient.auth.get('/barbershop/${userModel.barberShopId}');
        return Success(BarbershopModel.fromMap(data));
    }
  }
}
