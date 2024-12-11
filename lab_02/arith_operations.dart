// WAP to perform Addition, Subtraction, Multiplication, Division based on user choice using if, if..else..if, & switch.

import 'dart:io';

void main() {
  stdout.write('Enter a number: ');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Enter operator: ');
  String o = stdin.readLineSync()!;

  stdout.write('Enter another number number: ');
  int b = int.parse(stdin.readLineSync()!);

  if (o == '+') {
    print('$a $o $b = ${a + b}');
  } else if (o == '-') {
    print('$a $o $b = ${a - b}');
  } else if (o == '*') {
    print('$a $o $b = ${a * b}');
  } else if (o == '/') {
    print('$a $o $b = ${a / b}');
  } else {
    print('Invalid operator');
  }

  print('Usng Switch');

  switch (o) {
    case '+':
      print('$a $o $b = ${a + b}');
      break;
    case '-':
      print('$a $o $b = ${a - b}');
      break;
    case '*':
      print('$a $o $b = ${a * b}');
      break;
    case '/':
      print('$a $o $b = ${a / b}');
      break;
    default:
      print('Invalid operator');
  }
}
