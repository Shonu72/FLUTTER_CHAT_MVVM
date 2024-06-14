import 'package:equatable/equatable.dart';

class Charterer extends Equatable{
  const Charterer({
    required this.chartererId,
    required this.chartererName,
    required this.tier,
  });

  final String chartererId;
  final String chartererName;
  final String tier;

  factory Charterer.fromJson(Map<String, dynamic> json) => Charterer(
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
