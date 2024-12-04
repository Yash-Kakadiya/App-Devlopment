/* WAP to read marks of five subjects. Calculate percentage and print class accordingly.
Fail below 35, Pass Class between 35 to 45, Second Class between 45 to 60, First Class between 60
to 70, Distinction if more than 70. */

import 'dart:io';

void main() {
  List<int> marks = [];
  int sum = 0;

  for (int i = 1; i <= 5; i++) {
    stdout.write('Enter marks of subject $i: ');
    int x = int.parse(stdin.readLineSync()!);
    sum += x;
    marks.add(x);
  }

  double per = sum / 5;

  print('Percentage: $per');

  if (per <= 35) {
    print('Fail');
  } else if (per <= 45) {
    print('Pass');
  } else if (per <= 60) {
    print('Second class');
  } else if (per <= 70) {
    print('First class');
  } else if (per <= 100) {
    print('Distinction');
  } else {
    print('Invalid marks entered');
  }
}
