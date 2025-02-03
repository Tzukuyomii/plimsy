class Tank {
  String _id;
  double _maxCapacity;
  double _liters;
  String _prefix;
  double _permeability;
  double _weightSpec;

  Tank({
    required String id,
    required double maxCapacity,
    required double liters,
    required String prefix,
    required double permeability,
    required double weightSpec,
  })  : _id = id,
        _maxCapacity = maxCapacity,
        _liters = liters,
        _prefix = prefix,
        _permeability = permeability,
        _weightSpec = weightSpec;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'maxCapacity': _maxCapacity,
      'liters': _liters,
      'prefix': _prefix,
      'permeability': _permeability,
      'weightSpec': _weightSpec,
    };
  }

  // Getter e setter per `id`
  String get id => _id;
  set id(String value) {
    _id = value;
  }

  // Getter e setter per `maxCapacity`
  double get maxCapacity => _maxCapacity;
  set maxCapacity(double value) {
    if (value > 0) {
      _maxCapacity = value;
    } else {
      throw Exception('La capacità massima deve essere positiva.');
    }
  }

  // Getter e setter per `liters`
  double get liters => _liters;
  set liters(double value) {
    if (value >= 0 && value <= _maxCapacity) {
      _liters = value;
    } else {
      throw Exception('I litri devono essere tra 0 e $_maxCapacity.');
    }
  }

  // Getter e setter per `prefix`
  String get prefix => _prefix;
  set prefix(String value) {
    _prefix = value;
  }

  // Getter e setter per `permeability`
  double get permeability => _permeability;
  set permeability(double value) {
    _permeability = value;
  }

  // Getter e setter per `weightSpec`
  double get weightSpec => _weightSpec;
  set weightSpec(double value) {
    _weightSpec = value;
  }
}
