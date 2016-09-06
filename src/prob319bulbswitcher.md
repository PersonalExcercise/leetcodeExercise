# problem 319. Bulb Switcher

[题目链接](https://leetcode.com/problems/bulb-switcher/)

## 方法

直接放弃，英文堪忧。题目中`For the ith round, you toggle every i bulb`还是是指每i个中的第i个。

[share my o(1) solution with explanation](https://leetcode.com/discuss/91371/share-my-o-1-solution-with-explanation)写得很清晰了。

重复一下。

可以认为从第2轮开始就切换了。

第2轮切换的为2i的灯泡，即2,4,6,8,.., 

第3轮切换的是3i的灯泡，即3,6,9,12,...,

第4轮切换的是4i的灯泡，即4,8,12,16,...,

...

第n轮切换的是ni的灯泡，即n

所以，对灯泡i，其被切换的次数就是其`因子数-1`,因为1作为其因子，被排除了（第一轮不是切换，是打开）。

另，除完全平方数外，所有数的因子都是偶数（因子成对出现），而完全平方数因子数为奇数(平方根只算一个因子)。减去1后，就只有完全平方数的灯泡是亮着的。

而完全平方数的个数，就是对n开平方。

## 代码

```C++
class Solution {
public:
    int bulbSwitch(int n) {
        return sqrt(n) ;
    }
};
```

## 后记

越来越觉得智障了。