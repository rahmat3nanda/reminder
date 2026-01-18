enum Day {
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  const Day(this.value);

  final int value;

  static Day fromInt(int value) => Day.values.firstWhere(
    (Day day) => day.value == value,
    orElse: () => Day.monday,
  );
}
