// WAP to print numbers between two given numbers which is divisible by 2 but not divisible by 3.

import 'dart:io';

void main() {
  stdout.write('Enter first number: ');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Enter last number: ');
  int b = int.parse(stdin.readLineSync()!);

  print(
      '#umbers between $a and $b which is divisible by 2 but not divisible by 3 are ');

  for (int i = a; i <= b; i++) {
    if (i % 2 == 0 && i % 3 != 0) {
      print(i);
    }
  }
}
