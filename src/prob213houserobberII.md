# problem 213. House Robber II

[题目链接](https://leetcode.com/problems/house-robber-ii/)

## 方法

相比[1](prob198houserobber.md)，又多了一个限制条件 —— 首尾相连！

这时，可以认为，首位置和尾位置，其中一个状态确定，最后一个位置必然也确定了。

可以按照[Simple AC solution in Java in O(n) with explanation](https://leetcode.com/discuss/36544/simple-ac-solution-in-java-in-o-n-with-explanation)所言，将此问题化为I的问题：

1. 必然不偷房间1，那么后面所有房间满足的限制与I相同。

2. 必然不偷最后一个房间，那么前N-1个房间满足的限制与I相同。

上述两个问题的解覆盖了所有可能。因为不能出现偷房间1，又偷最后一个房间的情况。

最后，取二者最大值即可。

自己做的就是分情况讨论：

1. 不偷房间1，其余遵从I中限制；

2. 偷房间1，则必然不偷最后一个房间。

## 代码

```C++
class Solution {
public:
    int rob(vector<int>& nums) {
        unsigned sz = nums.size();
        if(sz == 0){ return 0; }
        else if(sz == 1){ return nums[0]; }
        vector<int> robR(sz),
                    notRobR(sz);
        int maxMoney = 0 ; 
        // 1. not rob house 1
        robR[0] = 0 ; 
        notRobR[0] = 0;
        for(size_t i = 1; i < sz; ++i)
        {
            robR[i] = notRobR[i-1] + nums[i];
            notRobR[i] = max(notRobR[i-1], robR[i-1]);
        }
        maxMoney = max(notRobR[sz-1], robR[sz-1]);
        // 2. rob house 1
        robR[0] = nums[0];
        notRobR[0] = nums[0];
        robR[1] = nums[0];
        notRobR[1] = nums[0];
        for(size_t i = 2; i < sz-1; ++i )
        {
            robR[i] = notRobR[i-1] + nums[i];
            notRobR[i] = max(notRobR[i-1], robR[i-1]);
        }
        maxMoney = max(maxMoney, max(robR[sz-2], notRobR[sz-2]));
        return maxMoney;
    }
};
```

## 后记

代码写出来很烂，而且各种边界错误... 