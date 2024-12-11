/*WAP to calculate the angle between the hour and minute hands of a clock, where the hours
and minutes are taken from the user. Example: Input: hours = 3, minutes = 15, Output: 7.5
(angle between the hands is 7.5 degrees).*/
import 'dart:io';
import 'dart:math';

void main() {

  stdout.write('Enter hour: ');
  int h = int.parse(stdin.readLineSync()!);

  stdout.write('Enter minute: ');
  int m = int.parse(stdin.readLineSync()!);

  double angle=((30*h)-(5.5*m)).abs();

  print('Angle of $h hour and $m minute is : $angle');
}
