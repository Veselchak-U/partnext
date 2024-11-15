enum ExperienceDuration {
  from0To2,
  from3To5,
  from6To10,
  from10,
  from20;

  @override
  String toString() {
    return switch (this) {
      ExperienceDuration.from0To2 => '0-2',
      ExperienceDuration.from3To5 => '3-5',
      ExperienceDuration.from6To10 => '6-10',
      ExperienceDuration.from10 => '10+',
      ExperienceDuration.from20 => '20+',
    };
  }
}
