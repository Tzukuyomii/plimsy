class Tanks {
  const Tanks(
      this.fuel, this.oil, this.freshW, this.urea, this.pool, this.sewage);

  final List<Object> fuel;
  final List<Object> oil;
  final List<Object> freshW;
  final List<Object> urea;
  final List<Object> pool;
  final List<Object> sewage;
}

class Pools {
  const Pools(this.pools);

  final List<Object> pools;
}
