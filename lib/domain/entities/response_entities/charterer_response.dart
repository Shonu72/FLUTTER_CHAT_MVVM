import 'package:charterer/domain/entities/charterer.dart';
import 'package:equatable/equatable.dart';


class ChartererResponse extends Equatable {

  final List<Charterer> chartererList;

  const ChartererResponse({
    required this.chartererList,
  });

  @override
  List<Object> get props => [chartererList];
}
