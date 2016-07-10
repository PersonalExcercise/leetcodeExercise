# problem 136. Single Number

[题目链接](https://leetcode.com/problems/single-number/)

## 方法

就喜欢这样的题，完全不会... 学习了后就明白了，希望能够记住吧。

1. A异或A等于0；

2. 异或运算满足交换律；

3. 0异或A等于A；

由上， 可知只需把数全部异或一遍就能够得到结果。

## 代码

```C++
class Solution {
public:
    int singleNumber(vector<int>& nums) {
        int result = 0;
        for(int num : nums){ result ^= num; }
        return result;
    }
};
```