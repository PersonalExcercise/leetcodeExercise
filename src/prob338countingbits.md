# problem 338. Counting Bits

[题目链接](https://leetcode.com/problems/counting-bits/)

## 方法

一下子灵光一现，竟然想到了！

连续的数，可以用DP啊。而且是求二进制中1的个数，我们只需要看当前数的最低位是不是1，记录下；然后右移一位，立即就可以用前一个状态来表示了。

当然此处的前一个状态不是说DP的前一个状态，而是经过右移一位后的状态:

```C++
R[i] = R[i>>1] + (R & 1)
R[0] = 0
```

一下子觉得好满足...

## 代码

```C++
class Solution {
public:
    vector<int> countBits(int num) {
        if(num < 0){ return {}; }
        vector<int> bitCnt(num+1);
        for(int i = 1; i <= num; ++i)
        {
            bitCnt[i] = bitCnt[i>>1] + (i & 1) ;
        }
        return bitCnt;
    }
};
```

## 后记

似乎还有找规律的一种DP方法，似乎是去掉最高位的1。这样每次在上一个状态下+1就好了。