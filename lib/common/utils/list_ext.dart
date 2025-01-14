extension ListExt on List {
  List<T> getEvenElements<T>() {
    return indexed.where((e) => e.$1 % 2 == 0).map((e) => e.$2 as T).toList();
  }

  List<T> getOddElements<T>() {
    return indexed.where((e) => e.$1 % 2 == 1).map((e) => e.$2 as T).toList();
  }
}
