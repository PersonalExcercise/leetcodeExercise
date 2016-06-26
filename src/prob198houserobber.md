# problem 198. House Robber

[题目链接](https://leetcode.com/problems/house-robber/)

## 方法

真是没想到可用设置两个状态序列来解！

不能连续偷连续的两件房间。我们可以设置两个状态序列A、B，

`A[i]`表示偷第i间时最大的收益；`B[i]`表示不偷第i间时的最大收益。

对于`A[i]`，由于偷第i间，所以不能偷第i-1间，所以其最大值必然等于 `B[i-1] + Num[i]`,即不偷第i-1间时的最大收益加上此间房间的收益；

对于`B[i]`，由于不偷第i间，那么对前1间，就可以偷，或者不偷。二者取最大值，就是不偷此间房间的最大收益。即`B[i] = max(B[i-1], A[i-1])`

最大的收益是`A[N-1]`, `B[N-1]`中的较大值。

最后，可以优化空间——只有前一个状态是对当前是有意义的。

## 代码

```C++
class Solution {
public:
    int rob(vector<int>& nums) {
        unsigned sz = nums.size();
        if(sz == 0){ return 0; }
        vector<int> notRobR(sz),
                    robR(sz);
        notRobR[0] = 0;
        robR[0] = nums[0];
        for(size_t i = 1; i < sz; ++i)
        {
            notRobR[i] = max(notRobR[i-1], robR[i-1]);
            robR[i] = notRobR[i-1] + nums[i];
        }
        return max(notRobR[sz-1], robR[sz-1]);
    }
};
```

## 后记

之前用一个状态序列来表示——R[i]表示必然偷第i间的收益，那么其相关的前向状态是R[i-2],R[i-3], 取其中较大者加上当前房间的收益。最后返回R[N-1],R[N-2]中的较大值。

想想不是很顺，但是还是过了。

看了DISCUSS，还是人家写得清楚。