// WAP to find maximum number from given two numbers using method.

import 'dart:io';

void main() {
  stdout.write('Enter a number: ');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Enter another number: ');
  int b = int.parse(stdin.readLineSync()!);

  print('Maximum number is ${maxOfTwo(a, b)}');
}

int maxOfTwo(int a, int b) {
  if (a > b) return a;
  return b;
}
