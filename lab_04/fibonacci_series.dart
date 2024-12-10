// WAP to generate Fibonacci series of N given number using method.

import 'dart:io';

void main() {
  stdout.write('Enter a number: ');
  int n = int.parse(stdin.readLineSync()!);
  fibonacci(n);
}

void fibonacci(int n) {
  int i = 1, j, ans = 0, k = 0;
  while (k < n) {
    stdout.write("$ans,");
    j = ans;
    ans = i + ans;
    i = j;
    k++;
  }
  stdout.write(" and so on...");
}
