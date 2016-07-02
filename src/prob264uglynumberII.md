# problem 264. Ugly Number II

[题目链接](https://leetcode.com/problems/ugly-number-ii/)

## 方法

这个题是看了题解才知道方法的（当时一定没看Hint）。提示已经非常地多了，就是用L2、L3、L5三个指针，指向3个uglyNumber，求出这三个uglyNumber分别乘上2、3、5后得到的值，最小值一定从这三个数中产生。产生当前最小丑数后，移动对应的指针。这三个数中很可能有重复的数。那么相应的应该都要移动指针。

## 代码

```C++
class Solution {
public:
    int nthUglyNumber(int n) {
        vector<int> uglyNumList(n,1);
        int L2 = 0,
            L3 = 0,
            L5 = 0;
        for(int i = 1; i < n; ++i)
        {
            int l2Num = uglyNumList[L2] * 2,
                l3Num = uglyNumList[L3] * 3,
                l5Num = uglyNumList[L5] * 5;
            int minVal = min(min(l2Num, l3Num), l5Num);
            if(minVal == l2Num){ ++L2; }
            if(minVal == l3Num){ ++L3; }
            if(minVal == l5Num){ ++L5; }
            uglyNumList[i] = minVal;
        }
        return uglyNumList.back();
    }
};
```

## 后记

看的DICUSS上的代码，从36ms缩短到了12ms。之前我的代码就是3个数判断，如果最小数大于vector中最后一个数就push进去。我觉得主要应该是vector扩增带来的性能损失。