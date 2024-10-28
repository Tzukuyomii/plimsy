import 'package:plimsy/models/tank.dart';

class Tanks {
  const Tanks(
      this.fuel, this.oil, this.freshW, this.urea, this.pool, this.sewage);

  final List<Tank> fuel;
  final List<Tank> oil;
  final List<Tank> freshW;
  final List<Tank> urea;
  final List<Tank> pool;
  final List<Tank> sewage;
}

class Pools {
  const Pools(this.pools);

  final List<Tank> pools;
}
