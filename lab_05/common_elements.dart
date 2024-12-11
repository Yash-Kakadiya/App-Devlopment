// WAP to read 2 list and return list that contains only the elements that are common between them.

import 'dart:io';

void main() {
  List<int> li1 = [];
  List<int> li2 = [];
  List<int> li3 = [];

  for (int i = 0; i < 5; i++) {
    stdout.write('Enter ${i + 1} number for list 1: ');
    li1.add(int.parse(stdin.readLineSync()!));
  }
  for (int i = 0; i < 5; i++) {
    stdout.write('Enter ${i + 1} number for list 2: ');
    li2.add(int.parse(stdin.readLineSync()!));
  }

  li3 = findCommonElements(li1, li2);

  print('Common numbers are $li3');
}

List<int> findCommonElements(List<int> li1, List<int> li2) {
  Set<int> set = Set<int>();

  li1.forEach((element) {
    set.add(element);
  });

  List<int> li3 = [];

  li2.forEach((element) {
    if (set.remove(element)) li3.add(element);
  });

  return li3;
}
