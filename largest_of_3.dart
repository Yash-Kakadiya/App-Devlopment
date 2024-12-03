// WAP to find out largest number from given three numbers without using Logical Operator.

import 'dart:io';

void main() {
  stdout.write('Enter first number: ');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Enter second number: ');
  int b = int.parse(stdin.readLineSync()!);

  stdout.write('Enter third number: ');
  int c = int.parse(stdin.readLineSync()!);

  if (a > b) {
    if (a > c) {
      print('$a is largest');
    } else {
      print('$c is largest');
    }
  } else {
    if (b > c) {
      print('$b is largest');
    } else {
      print('$c is largest');
    }
  }
}
