//An ugly number is defined as a number whose only prime factors are 2, 3, or 5.

import 'dart:io';
import 'dart:math';

void main() {
  stdout.write('Enter number : ');
  int n = int.parse(stdin.readLineSync()!);

  for (int i = 2; i <= n; i++) {
    if (n % i == 0) {
      if ((i != 2 || i != 3 || i != 5) || isPrime(n)) {
        print('$n is not ugly number');
        return;
      }
    }
  }
  print('$n is ugly number');
}

bool isPrime(int n) {
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}
