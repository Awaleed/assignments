class SailorParam<T> {
  final String name;
  final T? defaultValue;
  final bool isRequired;
  final Type paramType;

  SailorParam({
    required this.name,
    this.defaultValue,
    this.isRequired = false,
  }) : paramType = T;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || other is SailorParam && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
