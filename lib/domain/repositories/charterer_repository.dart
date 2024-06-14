import 'package:charterer/domain/entities/response_entities/charterer_response.dart';

import '../../core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChartererRepository {
  Future<Either<Failure, Map<String, dynamic>>> addCharterer({
    String? fullName,
    String? email,
    String? country,
    String? mobileNumber,
    String? address,
    String? state,
    String? city,
    String? website,
  });

  Future<Either<Failure, ChartererResponse>> getCharterers({String? search});
}
