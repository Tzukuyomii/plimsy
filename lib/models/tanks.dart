import 'package:plimsy/models/tank.dart';

class Tanks {
  // Proprietà private
  List<Tank> _fuel;
  List<Tank> _oil;
  List<Tank> _freshW;
  List<Tank> _urea;
  List<Tank> _pool;
  List<Tank> _sewage;

  Tanks(
      {required List<Tank> fuel,
      required List<Tank> oil,
      required List<Tank> freshW,
      required List<Tank> urea,
      required List<Tank> pool,
      required List<Tank> sewage})
      : _fuel = fuel,
        _oil = oil,
        _freshW = freshW,
        _urea = urea,
        _pool = pool,
        _sewage = sewage;

  // Getter
  List<Tank> get fuel => _fuel;
  List<Tank> get oil => _oil;
  List<Tank> get freshW => _freshW;
  List<Tank> get urea => _urea;
  List<Tank> get pool => _pool;
  List<Tank> get sewage => _sewage;

  // Setter
  set fuel(List<Tank> value) {
    _fuel = value;
  }

  set oil(List<Tank> value) {
    _oil = value;
  }

  set freshW(List<Tank> value) {
    _freshW = value;
  }

  set urea(List<Tank> value) {
    _urea = value;
  }

  set pool(List<Tank> value) {
    _pool = value;
  }

  set sewage(List<Tank> value) {
    _sewage = value;
  }
}

class Pools {
  List<Tank> _pools;

  Pools({required List<Tank> pools}) : _pools = pools;
  List<Tank> get pools => _pools;

  set pools(List<Tank> value) {
    _pools = value;
  }
}
