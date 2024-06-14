import 'package:charterer/data/models/charterer_model.dart';
import '../../../domain/entities/response_entities/charterer_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class ChartererResponseModel extends ChartererResponse {

  final List<ChartererModel> chartererList;

  const ChartererResponseModel({
    required this.chartererList,
  }) : super(chartererList: chartererList);

  @override
  List<Object> get props => [chartererList];

  factory ChartererResponseModel.fromJSON(Map<String, dynamic> json) =>
      ChartererResponseModel(
        chartererList: (json['data'] as List<dynamic>)
            .map<ChartererModel>((charterer) => ChartererModel.fromJson(charterer))
            .toList(),
      );
}
