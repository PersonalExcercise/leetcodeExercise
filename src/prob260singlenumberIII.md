# problem 260. Single Number III

[题目链接](https://leetcode.com/problems/single-number-iii/)

## 方法

[Accepted C++/Java O(n)-time O(1)-space Easy Solution with Detail Explanations](https://discuss.leetcode.com/topic/21605/accepted-c-java-o-n-time-o-1-space-easy-solution-with-detail-explanations)

非常巧妙啊！由于数中有两个不相同的数只出现了一次。那么我们第一遍用XOR扫，得到的数就是这两个数XOR的结果。其中位为1的那些位，表示两个数在该位上不一样！

于是！我们就可以根据该位的值来将原来的数划分为两个集合！首先，这两个不同的数必然分别在两个集合中；其次，其他所有出现两次的数必然同样成对被划分到某一集合中（因为数是相同的，所以划分结果当然相同）。这样，在子集合中，又是变为了 single number I 的情况。

## 代码

```C++
class Solution {
public:
    vector<int> singleNumber(vector<int>& nums) {
        // learned from https://discuss.leetcode.com/topic/21605/accepted-c-java-o-n-time-o-1-space-easy-solution-with-detail-explanations
        int xorResult = 0;
        for(int num : nums){ xorResult ^= num; }
        int splitBit = -xorResult & xorResult;
        vector<int> result(2,0);
        for(int num : nums){ result[static_cast<int>((num & splitBit) == 0)] ^= num; }
        return result;
    }
};
```
