import 'package:charterer/domain/entities/response_entities/charterer_response.dart';
import 'package:dartz/dartz.dart';
import '../../core/usecases/charterer_params.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/failure.dart';
import '../repositories/charterer_repository.dart';


class GetCharterers extends UseCase<ChartererResponse, Params> {
  final ChartererRepository _repository;

  GetCharterers(this._repository);

  @override
  Future<Either<Failure, ChartererResponse>> call(Params params) {
    return _repository.getCharterers(
      search: params.chartererParams?.search,
    );
  }
}
