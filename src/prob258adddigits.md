# problem 258. Add Digits

[题目链接](https://leetcode.com/problems/add-digits/)

## 方法

把一个数的各位数字相加，如果结果大于10，则迭代此过程，知道结果只有一位数字。此结果就是数根。

数根的求法见[维基百科](https://en.wikipedia.org/wiki/Digital_root):

```C++
digital root = n - (n - 1) / 9 * 9;
```

## 代码

```C++
class Solution {
public:
    int addDigits(int num) {
        return num - (num-1)/ 9 * 9;
    }
};
```
