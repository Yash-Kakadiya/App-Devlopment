// WAP to print given number in reverse order.

import 'dart:io';

void main() {
  stdout.write('Enter number to reverse: ');
  int n = int.parse(stdin.readLineSync()!);
  print('Orignal number: $n');

  int rev = 0;

  while (n > 0) {
    rev = rev * 10 + (n % 10);
    n ~/= 10;
  }
  print('Reversed Number: $rev');
}
