import 'dart:io';

void main() {
  List<int> marks=[];
  int sum=0;

  for(int i=1;i<=5;i++) {
    stdout.write('Enter marks of subject $i out of 100: ');
    int x=int.parse(stdin.readLineSync()!);
    marks.add(x);
    sum+=x;
  }
  print('Percent of marks $marks is ${(sum)/5}');
}
