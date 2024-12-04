/* WAP to find the element that appears only once in a non-empty array of integers, where every
other element appears twice. The solution should have linear runtime complexity and use only
constant extra space. Example: Input: nums = [2, 2, 1], Output: 1; Input: nums = [4, 1, 2, 1, 2],
Output: 4; Input: nums = [1], Output: 1.*/

import 'dart:io';

void main() {
  List<int> list = [4, 1, 2, 1, 2, 4, 5, 6, 5, 7, 6];
  int result = 0;

  for (int i = 0; i < list.length; i++) {
    result ^= list[i];
  }
  print('$list -> $result');
}
