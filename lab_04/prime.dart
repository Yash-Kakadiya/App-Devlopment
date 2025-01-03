/* WAP to accept a number and check whether the number is prime or not. Use method name
check (int n). The method returns 1, if the number is prime otherwise, it returns 0.*/

import 'dart:io';
import 'dart:math';

void main() {
  stdout.write('Enter number to find if it is prime or not: ');
  int n = int.parse(stdin.readLineSync()!);

  if (isPrime(n:n) == 1) {
    print('$n is prime number');
  } else {
    print('$n is not prime number');
  }
}

int isPrime({required int n}) {
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) {
      return 0;
    }
  }
  return 1;
}
