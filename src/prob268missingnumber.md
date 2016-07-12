# problem 268. Missing Number

[题目链接](https://leetcode.com/problems/missing-number/)

## 方法

妈的智障。

前面已经把single number系列给做完了，也就知道了除了一个数只出现一次外，所有数均出现两次，求这个只出现一次的数的方法。

这个题，稍微转换一下，就是上面这个题了啊。0 ~ n， n+1个数，数组中列出了n个数，找缺失的数。的确立刻就转换为了single number问题。自己就是想不到啊。

## 代码

```C++
class Solution {
public:
    int missingNumber(vector<int>& nums) {
        // learned from https://discuss.leetcode.com/topic/22313/c-solution-using-bit-manipulation
        int sz = nums.size();
        int result = sz;
        for(int i = 0; i < sz; ++i) { result ^= nums[i] ^ i ; }
        return result;
    }
};
```