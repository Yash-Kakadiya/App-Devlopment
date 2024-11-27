import 'dart:io';

void main() {

  stdout.write('Enter mass in pound to find BMI: ');
  double lb=double.parse(stdin.readLineSync()!);
  double kg= 0.453592*lb;

  stdout.write('Enter height in inches to find BMI: ');
  double i =double.parse(stdin.readLineSync()!);
  double m=0.0254*i;

  double bmi=kg/(m*m);

  print('Your weight is $kg kg with height of $m meters. BMI = $bmi');
}
