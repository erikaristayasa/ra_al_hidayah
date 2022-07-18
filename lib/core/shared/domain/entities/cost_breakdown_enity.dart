import 'package:equatable/equatable.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';

class CostBreakdown extends Equatable {
  final int id;
  final int reRegistrationId;
  final GradeType type;
  final int maleActivity;
  final int maleStationary;
  final int maleSpp;
  final int maleUniform;
  final int maleHood;
  final int maleBuildingMoney;
  final int maleTotalCost;
  final int femaleActivity;
  final int femaleStationary;
  final int femaleSpp;
  final int femaleUniform;
  final int femaleHood;
  final int femaleBuildingMoney;
  final int femaleTotalCost;

  const CostBreakdown({
    required this.id,
    required this.reRegistrationId,
    required this.type,
    required this.maleActivity,
    required this.maleStationary,
    required this.maleSpp,
    required this.maleUniform,
    required this.maleHood,
    required this.maleBuildingMoney,
    required this.maleTotalCost,
    required this.femaleActivity,
    required this.femaleStationary,
    required this.femaleSpp,
    required this.femaleUniform,
    required this.femaleHood,
    required this.femaleBuildingMoney,
    required this.femaleTotalCost,
  });

  @override
  List<Object?> get props => [
        id,
        reRegistrationId,
        type,
        maleActivity,
        maleStationary,
        maleSpp,
        maleUniform,
        maleHood,
        maleBuildingMoney,
        maleTotalCost,
        femaleActivity,
        femaleStationary,
        femaleSpp,
        femaleUniform,
        femaleHood,
        femaleBuildingMoney,
        femaleTotalCost,
      ];
}
