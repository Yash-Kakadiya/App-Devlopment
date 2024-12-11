// WAP that creates List with following value:“Delhi”, “Mumbai”, “Bangalore”, “Hyderabad” and “Ahmedabad” Replace “Ahmedabad” with “Surat” in above List.

import 'dart:io';

void main() {
  List<String> li = ['Delhi', 'Mumbai', 'Bangalore', 'Hyderabad', 'Ahmedabad'];

  int idx = li.indexOf('Ahmedabad');
  if (idx != -1) li[idx] = 'Surat';

  print(li);
}
