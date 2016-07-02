# problem 122. Best Time to Buy and Sell Stock II

[题目链接](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/)


## 方法

这道题竟然被吐槽`is a joke`...

看起来似乎的确很简单，任意次数的交易，也没有任何条件限制，只管在价格降低前卖掉，在价格低点买入即可。即是说，如果构建一个一阶差分数组，那么只需要把其中的正数加起来就可以了...

幸好我是从后面的，有cooldown的题来的。知道后面还是很难的...不然我也会很开心..

## 代码

```C++
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int curMaxProfit = 0;
        size_t days = prices.size();
        for(size_t i = 1; i < days; ++i)
        {
            if(prices[i] > prices[i-1])
            {
                curMaxProfit += prices[i] - prices[i-1];
            }
        }
        return curMaxProfit;
    }
};
```