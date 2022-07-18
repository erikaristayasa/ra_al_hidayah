import 'package:equatable/equatable.dart';

import 'cost_breakdown_enity.dart';

class ReRegistration extends Equatable {
  final int id;
  final int periodId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<CostBreakdown> costBreakdowns;

  const ReRegistration({
    required this.id,
    required this.periodId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.costBreakdowns,
  });

  @override
  List<Object?> get props => [
        id,
        periodId,
        title,
        description,
        startDate,
        endDate,
        costBreakdowns,
      ];
}
