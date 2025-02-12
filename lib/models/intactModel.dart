class Intactmodel {
  final String forcedHeeling;

  Intactmodel({required this.forcedHeeling});

  factory Intactmodel.fromJson(Map<String, dynamic> json) {
    return Intactmodel(
      forcedHeeling: json["forcedHeeling"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "forcedHeeling": forcedHeeling,
    };
  }

  Intactmodel copyWith({String? forcedHeeling}) {
    return Intactmodel(
      forcedHeeling: forcedHeeling ?? this.forcedHeeling,
    );
  }

  @override
  String toString() => 'Intactmodel(forcedHeeling: $forcedHeeling)';
}
