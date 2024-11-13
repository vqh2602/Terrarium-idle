
class SelectOptionItem<T> {
  String? key;
  String? value;
  T? data;
  bool? status = false;
  SelectOptionItem({
    required this.key,
    this.value,
    this.data,
    this.status,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectOptionItem<T> &&
        other.key == key &&
        other.value == value &&
        other.data == data &&
        other.status == status;
  }

  @override
  int get hashCode {
    return key.hashCode ^ value.hashCode ^ data.hashCode ^ status.hashCode;
  }
}
