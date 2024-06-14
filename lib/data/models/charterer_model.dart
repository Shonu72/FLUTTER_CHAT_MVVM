// ignore_for_file: overridden_fields, annotate_overrides
import 'package:equatable/equatable.dart';
import '../../domain/entities/charterer.dart';

class ChartererModel extends Charterer{
  const ChartererModel({
    required this.chartererId,
    required this.chartererName,
    required this.tier,
  }) : super(chartererId: chartererId, chartererName: chartererName, tier: tier);

  final String chartererId;
  final String chartererName;
  final String tier;

  factory ChartererModel.fromJson(Map<String, dynamic> json) => ChartererModel(
    chartererId: json["chartererId"],
    chartererName: json["chartererName"],
    tier: json["Tier"],
  );

  Map<String, dynamic> toJson() => {
    "chartererId": chartererId,
    "chartererName": chartererName,
    "Tier": tier,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [chartererId, chartererName, tier];
}
