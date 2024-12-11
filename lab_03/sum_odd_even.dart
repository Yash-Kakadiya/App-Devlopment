/* WAP program to calculate the sum of all positive even numbers and the sum of all negative
odd numbers from a set of numbers. you can enter 0 (zero) to quit the program and thus it
displays the result. */

import 'dart:io';

void main() {
  stdout.write('Enter number : ');
  int n = int.parse(stdin.readLineSync()!);

  int oddNegSum = 0;
  int evenPosSum = 0;

  List<int> oddNegList=[];
  List<int> evenPosList=[];

  while (n != 0) {
    if (n % 2 == 0 && n > 0) {
      evenPosList.add(n);
      evenPosSum += n;
    }
    if (n % 2 == 1 && n < 0) {
      oddNegList.add(n);
      oddNegSum += n;
    }
    stdout.write('Enter another number : ');
    n = int.parse(stdin.readLineSync()!);
  }

  print('Sum of negative odd Numbers $oddNegList is $oddNegSum');
  print('Sum of positive even Numbers $evenPosList is $evenPosSum');
}
