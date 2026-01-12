import 'package:flutter_riverpod/flutter_riverpod.dart';

// Manages the selected tab in the Office section (0: My bots, 1: Marketplace)
class OfficeSelectedIndex extends Notifier<int> {
  @override
  int build() => 0;

  void updateIndex(int value) => state = value;
}

final officeSelectedIndexProvider = NotifierProvider<OfficeSelectedIndex, int>(
  OfficeSelectedIndex.new,
);
