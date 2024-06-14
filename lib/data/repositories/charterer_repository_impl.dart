import 'package:charterer/core/utils/failure.dart';
import 'package:charterer/data/datasources/charterer_remote_datasource.dart';
import 'package:charterer/domain/entities/response_entities/charterer_response.dart';
import 'package:charterer/domain/repositories/charterer_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/utils/exceptions.dart';

class ChartererRepositoryImpl extends ChartererRepository{

  final ChartererRemoteDatasource _chartererRemoteDatasource;

  ChartererRepositoryImpl(this._chartererRemoteDatasource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> addCharterer({String? fullName, String? email, String? country, String? mobileNumber, String? address, String? state, String? city, String? website}) async{
    try {
      return Right(await _chartererRemoteDatasource.addCharterer(fullName, email, country, mobileNumber, address, state, city, website));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ChartererResponse>> getCharterers({String? search})async {
    try {
      return Right(await _chartererRemoteDatasource.getCharterers(search));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

}