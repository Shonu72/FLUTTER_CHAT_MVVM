import 'package:dartz/dartz.dart';
import '../../core/usecases/charterer_params.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/failure.dart';
import '../repositories/charterer_repository.dart';


class AddCharterer extends UseCase<Map<String, dynamic>, Params> {
  final ChartererRepository _repository;

  AddCharterer(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.addCharterer(
      fullName: params.chartererParams?.fullName,
      email: params.chartererParams?.email,
      country: params.chartererParams?.country,
      mobileNumber: params.chartererParams?.mobileNumber,
      address: params.chartererParams?.address,
      state: params.chartererParams?.state,
      city: params.chartererParams?.city,
      website: params.chartererParams?.website,
    );
  }
}
