// WAP to find out largest number from given 3 numbers using conditional operator.

import 'dart:io';

void main() {
  stdout.write('Enter first number: ');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Enter second number: ');
  int b = int.parse(stdin.readLineSync()!);

  stdout.write('Enter third number: ');
  int c = int.parse(stdin.readLineSync()!);

  int x = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);
  print('$x is largest');
}
