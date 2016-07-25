# problem 342. Power of Four

[题目链接](https://leetcode.com/problems/power-of-four/)

## 方法

首先想到的是是否是2个幂，然后再想，之间的差别就是，4的幂每次移动都是2位两位的。

可以用一个循环来判断。

然后看到题解中使用 (n & 0x55555555) != 0 来判断。因为5的二进制表示是 0101，如果是2的幂但不是4的幂，与上后就变成0了。

注意！ &的优先级低于 == , != , 所以必须加括号啊！！！

## 代码

```C++
class Solution {
public:
    bool isPowerOfFour(int num) {
        return (num > 0 && (num & (num - 1)) == 0  && (num & 0x55555555) != 0);
    }
};
```