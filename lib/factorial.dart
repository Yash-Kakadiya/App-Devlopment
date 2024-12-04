// WAP to find factorial of the given number.

import 'dart:io';

void main() {
  stdout.write('Enter number to find factorial: ');
  int n = int.parse(stdin.readLineSync()!);

  int ans = 1;

  for (int i = 1; i <= n; i++) {
    ans *= i;
  }
  print('Factorial of $n is $ans');
}
