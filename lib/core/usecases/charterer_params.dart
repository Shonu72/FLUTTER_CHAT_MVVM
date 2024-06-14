import 'package:equatable/equatable.dart';

class ChartererParams extends Equatable{

  final String? fullName;
  final String? email;
  final String? country;
  final String? mobileNumber;
  final String? address;
  final String? state;
  final String? city;
  final String? website;
  final String? search;

  const ChartererParams({this.search, this.fullName, this.email, this.country, this.mobileNumber, this.address, this.state, this.city, this.website});

  @override
  // TODO: implement props
  List<Object?> get props => [];



}