import 'dart:io';

void main() {

    stdout.write('Enter number meter to convert into feet: ');
    double m=double.parse(stdin.readLineSync()!);
    double feet= ((m*100)/2.54)/12;

  print('$m m = ${feet.toStringAsFixed(5)} feet');
}
