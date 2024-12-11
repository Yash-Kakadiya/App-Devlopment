// WAP to accept n numbers in an array. Display the sum of all the numbers which are divisible by either 3 or 5.

import 'dart:io';

void main() {
  List<int> li = [];
  List<int> li2 = [];

  int sum = 0;
  for (int i = 0; i < 5; i++) {
    stdout.write('Enter ${i + 1} number: ');
    int n = int.parse(stdin.readLineSync()!);
    li.add(n);
    if (n % 3 == 0 || n % 5 == 0) {
      li2.add(n);
      sum += n;
    }
  }
  print('You entered $li');
  print('Numbers divisible by either 3 or 5. $li2');
  print('Sum of that numbers is $sum');
}
