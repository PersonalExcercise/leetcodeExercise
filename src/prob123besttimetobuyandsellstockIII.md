###problem 123  Best Time to Buy and Sell Stock III

[link](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/)


给一个数组，第i个值表示这个股票在第i天的价格。最多允许两次`trasaction`（买之前必须卖掉），问最大的利润！

开始给想成了“不断找递增子序列，求出每个递增子序列的最大值与最小值的差作为利润，然后求这些利润中最大的两个相加”，在修复一些BUG后依然错误，第181个case如下：

`[ 1,2,4, 2,5,7 , 2,4,9,0 ]`

按照我想的方法，结果是 `max2(3 , 5 , 7 , 0) = 5 + 7 = 12`，但是结果是13，即选`1,7,2,9`这4个值！可以发现，最大利润出现在并非是连续的递增序列中，而是先增后减再增的过程中！

因而上面就想错了！！

题解上的做法是，建立两个记录，一个是前向记录f, `f(i)`表示从0到i中最大的利润。i取值为0到n-1；再定义一个后向记录g,`g(i)`表示从i到n-1区段中最大的利润。i的取值为n-1到0；

前向记录的计算：

定义从0~n-1的循环，每次迭代

1. 更新这个过程中的`最小值`；

2. 用此次迭代位置的价格减去最小值，与`f(i-1)`比较，取较大者；

后向记录的计算：

定义n-1~0的循环，每次迭代：

1. 更新这个过程中的`最大值`

2. 用最大值减去迭代位置的值，与`g(i+1)`比较，取较大者。

合并结果：

就像前向-后向方法一样，求 `f(i)+g(i)` ， i取0到n-1中最大的值。

刚开始觉得麻烦，后来意识到自己的方法错了之后，觉得还是6啊。

题解中还提到了，构建`差分序列`！求最大2子段和。之后再看看...

###代码

基本照搬题解。

    ```C++
    class Solution {
    public:
        int maxProfit(vector<int>& prices) {
            int days = prices.size() ;
            if( days < 2 ) return 0 ;
            vector<int> forward(days , 0) ;
            vector<int> backward(days , 0) ;
            for(int i = 1 , valley = prices[0] ; i < days ; ++i )
            {
                valley = min(valley , prices[i]) ;
                forward[i] = max(prices[i] - valley , forward[i-1]) ;
            }
            for(int i = days - 2 , peak = prices[days -1] ; i >= 0 ; --i )
            {
                peak = max(peak , prices[i]) ;
                backward[i] = max(peak - prices[i] , backward[i+1]) ;
            }
            
            int max_profit = 0 ;
            for(int i = 0 ; i < days ; ++i) max_profit = max(max_profit , forward[i] + backward[i]) ;
            return max_profit ;
        }
    };
    ```
