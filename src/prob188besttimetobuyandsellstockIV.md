# problem 188. Best Time to Buy and Sell Stock IV

[题目链接](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/)

## 方法

这个题就是第三个题、第二个题的综合体。

首先考虑K值很小的情况。由第三题，我们知道，对K次交易，每次买入就是在当前已有的本钱上减去股票价格并取最大，每次卖出就是在当前本钱上加上当前价格再取最大。所以我们只需要分别建立K个买入价格、卖出价格的数组来记录就好了。

其次是K值很大，超过了天数。这样其实就相当于第二题，即操作次数不受限。只需要把股票价格的增量全部加起来就好了。

## 代码

```C++
class Solution {
public:
    int maxProfit(int k, vector<int>& prices) {
        size_t days = prices.size();
        if(days == 0){ return 0; }
        if(k <= 0){ return 0; }
        if(k >= days)
        {
            int maxProfit = 0;
            for(int i = 1; i < days; ++i)
            {
                if(prices[i] > prices[i-1]){ maxProfit += prices[i] - prices[i-1]; }
            }
            return maxProfit;
        }
        else
        {
            vector<int> maxBuyLeft(k, -prices[0]),
                        maxSellLeft(k,0);
            for(int i = 1; i < days; ++i)
            {
                maxBuyLeft[0] = max(maxBuyLeft[0], -prices[i]);
                maxSellLeft[0] = max(maxSellLeft[0], maxBuyLeft[0] + prices[i]);
                for(int transactionTime = 1; transactionTime < k; ++transactionTime)
                {
                    maxBuyLeft[transactionTime] = max(maxBuyLeft[transactionTime], 
                                                      maxSellLeft[transactionTime-1] - prices[i]);
                    maxSellLeft[transactionTime] = max(maxSellLeft[transactionTime],
                                                      maxBuyLeft[transactionTime] + prices[i]);
                }
            }
            return maxSellLeft.back();   
        }
    }
};
```

## 后记

边界条件之前是一点没考虑啊... k=0时就应该返回0，k大于天数后就应该是不受限的买卖。不然用第三题的方法，内存就要爆了。
