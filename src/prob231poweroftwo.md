# problem 231. Power of Two

[题目链接](https://leetcode.com/problems/power-of-two/)

## 方法

因为是2个power，非常熟悉的性质——我们不断左移，就相当于不断乘以2，即是2个power。因而，只要数的二进制表示只有1个1，且，这个1不是出现在符号位，那么就可定是2的倍数了。可以使用 (N & N - 1) 来清除lowest significant 1，如果清除后为0，那么就OK了。

但在以下两个case中均出错了：

1. n = 0

2. n = -2147483648 （INT_MIN）

第一个是考虑不周，因为0与上任何数都为0；第二个呢？因为最小数的二进制表示是：只有符号位为1。所以去掉符号位后就成0了。

其实一个很简单的处理就是——只有n大于0的情况才是有可能的。这是很直观的，从数学性质就可以推算出来的。

## 代码

```C++
class Solution {
public:
    bool isPowerOfTwo(int n) {
        return n > 0  && (n & n - 1 ) == 0 ;
    }
};
```