# problem 326. Power of Three

[题目链接](https://leetcode.com/problems/power-of-three/)

## 方法

再也没有黑魔法了，要么用循环判断；要么用math pow 与 log 来算。 注意，每次做完 pow 和 log之后记得取整，而且内层必须用round，不能trunc！

对了，还可以求对INT_MAX下最大的3的幂值X。然后求 X % n == 0 就可以了！ 这个有点神奇，不过对于素数，这点是成立的！

设 3^t = X , 3^m = n , 那么 X / n = 3^(t-m) , 即整除，故模为0；且整除下，若X是3的幂，因为3是素数，故被X整除的数必然也是3的幂。

## 代码

```C++
class Solution {
public:
    bool isPowerOfThree(int n) {
        if(n < 1){ return false; }
        return static_cast<int>(pow(3, static_cast<int>( round(log(n)/ log(3)) ))) == n ;
    }
};
```