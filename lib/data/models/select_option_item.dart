// ignore_for_file: public_member_api_docs, sort_constructors_first

class SelectOptionItem {
  String? key;
  String? value;
  dynamic data;

  SelectOptionItem({
    required this.key,
    required this.value,
    required this.data,
  });

  SelectOptionItem copyWith({
    String? key,
    String? value,
    dynamic data,
  }) {
    return SelectOptionItem(
      key: key ?? this.key,
      value: value ?? this.value,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(covariant SelectOptionItem other) {
    if (identical(this, other)) return true;

    return other.key == key && other.value == value && other.data == data;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode ^ data.hashCode;

  @override
  String toString() =>
      'SelectOptionItem(key: $key, value: $value, data: $data)';
}
