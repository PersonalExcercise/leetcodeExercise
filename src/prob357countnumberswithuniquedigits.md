# problem 357. Count Numbers with Unique Digits

[题目链接](https://leetcode.com/problems/count-numbers-with-unique-digits/)

## 方法

完了，这个题没有看hint我竟然不会... 我觉得我愧对刘老师了...

其实就是N位数，有多少个数字不相同的数... 这不是送分题吗？ 只怪给的Example里面用的exluding把我误导到了另一个方面。

当然，还是我得锅。

## 代码

```C++
class Solution {
public:
    int countNumbersWithUniqueDigits(int n) {
        if(n == 0){ return 1; }
        else if(n == 1){ return 10; }
        else if(n == 2){ return 10 + 9*9; }
        else
        {
            int maxN = min(n, 10);
            int num = 10 + 9*9,
                preDigitNum = 9*9;
            for(int digitNum = 3; digitNum <= maxN; ++digitNum)
            {
                preDigitNum *= 10 - digitNum + 1;
                num += preDigitNum;
            }
            return num;
        }
    }
};
```