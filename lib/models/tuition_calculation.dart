class TuitionCalculation {
  final String levelId;
  final String levelName;
  final double baseTuition;
  final bool hasTransport;
  final double transportCost;
  final bool hasCafeteria;
  final double cafeteriaCost;
  final int workshopCount;
  final double workshopCostPerItem;

  const TuitionCalculation({
    required this.levelId,
    required this.levelName,
    required this.baseTuition,
    required this.hasTransport,
    required this.transportCost,
    required this.hasCafeteria,
    required this.cafeteriaCost,
    required this.workshopCount,
    required this.workshopCostPerItem,
  });

  double get totalWorkshopsCost => workshopCount * workshopCostPerItem;
  double get totalMonthlyInvestment => 
      baseTuition + (hasTransport ? transportCost : 0) + (hasCafeteria ? cafeteriaCost : 0) + totalWorkshopsCost;
  
  double get annualInvestment => totalMonthlyInvestment * 10; // 10 meses de ciclo escolar
}
