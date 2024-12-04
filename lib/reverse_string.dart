// WAP to print reverse string.

import 'dart:io';

void main() {
  stdout.write('Enter number to reverse: ');
  String str = stdin.readLineSync()!;
  print('Orignal String: $str');

  String rev = "";

  for (int i = str.length - 1; i >= 0; i--) {
    rev += str[i];
  }
  print('Reversed String: $rev');
}
