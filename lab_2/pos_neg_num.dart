// WAP to check whether the given number is positive or negative.

import 'dart:io';

void main() {
  stdout.write('Enter a number: ');
  int n = int.parse(stdin.readLineSync()!);

  if (n >= 0) {
    print('$n is positive integer');
  } else {
    print('$n is negative integer');
  }
}
