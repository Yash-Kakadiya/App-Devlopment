// WAP to count number of even or odd number from an array of n numbers.
import 'dart:io';

void main() {
  stdout.write('Enter size of array: ');
  int n = int.parse(stdin.readLineSync()!);
  List<int> li = scanArray(n);

  print(li);
  print('Count of odd numbers is ${countOdd(li)}');
  print('Count of even numbers is ${countEven(li)}');
}

List<int> scanArray(int n) {
  List<int> li = [];

  for (int i = 0; i < n; i++) {
    stdout.write('Enter element for [${i + 1}] position: ');
    li.add(int.parse(stdin.readLineSync()!));
  }
  return li;
}

int countOdd(List<int> li) {
  int count = 0;

  for (int i = 0; i < li.length; i++) {
    if (li[i] % 2 != 0) count++;
  }
  return count;
}

int countEven(List<int> li) {
  int count = 0;

  for (int i = 0; i < li.length; i++) {
    if (li[i] % 2 == 0) count++;
  }
  return count;
}
