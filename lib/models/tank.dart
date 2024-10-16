class Tank {
  const Tank(
      {required this.id,
      required this.maxCapacity,
      required this.liters,
      required this.prefix,
      required this.permeability,
      required this.weightSpec});

  final String id;
  final double maxCapacity;
  final double liters;
  final String prefix;
  final double permeability;
  final double weightSpec;
}
