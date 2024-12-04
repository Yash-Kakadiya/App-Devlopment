// WAP to find whether the given number is prime or not.

import 'dart:io';
import 'dart:math';

void main() {
  stdout.write('Enter number to find if it is prime or not: ');
  int n = int.parse(stdin.readLineSync()!);

  if (isPrime(n)) {
    print('$n is prime number');
  } else {
    print('$n is not prime number');
  }
}

bool isPrime(int n) {
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}
