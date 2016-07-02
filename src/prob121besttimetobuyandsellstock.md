# problem 121. Best Time to Buy and Sell Stock

[题目链接](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)

## 方法

EASY-tag的题。之前做过III，就显得更加简单了。

用一个值不断记录到当前位置的最低买入价格，用当前价格减去买入就是利润。然后比较当前利润与前一个时刻的利润，取较大者。

## 代码

```C++
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        size_t sz = prices.size();
        if(sz == 0){ return 0; }
        int currentMaxProfit = 0;
        int valley = prices[0];
        for(int i = 1; i < sz; ++i)
        {
            if(prices[i] < valley){ valley = prices[i]; }
            currentMaxProfit = max(currentMaxProfit, prices[i] - valley);
        }
        return currentMaxProfit;
    }
};
```
