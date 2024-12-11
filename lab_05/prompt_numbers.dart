// WAP that prompts the user to enter 5 numbers, stores them in a List, and displays them in increasing order.

import 'dart:io';

void main() {
  List<int> li = [];
  for (int i = 0; i < 5; i++) {
    stdout.write('Enter ${i + 1} number: ');
    li.add(int.parse(stdin.readLineSync()!));
  }

  li.sort();
  print(li);
}
