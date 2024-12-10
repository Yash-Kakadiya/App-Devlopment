// WAP to calculate simple interest using method.

import 'dart:io';

void main() {
  stdout.write('Enter principle amount: ');
  int p = int.parse(stdin.readLineSync()!);

  stdout.write('Enter rate of interest: ');
  double r = double.parse(stdin.readLineSync()!);

  stdout.write('Enter time period in years: ');
  int t = int.parse(stdin.readLineSync()!);

  double inte = calcInt(p, r, t);
  print('Interest is $inte');
  print('Total amount is ${inte + p}');
}

double calcInt(int p, double r, int t) {
  return p * r * t / 100;
}
