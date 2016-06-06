# problem 62. Unique Paths

[link](https://leetcode.com/problems/unique-paths/)

## 方法

就使用动态规划而言，这道题与爬梯子很像，就是到达当前位置的不同路径数等于到达上边、左边位置的路径和。

这道题可以直接从数学角度求解——mxn的格子，从左上到右下，只能向右或下，那么**其路径必然是m-1个“右”，n-1个“下”**构成的序列。所以不同的路径，就是求所有m-1个“右”和n-1个“下”组合的方法数，即 `C(m-1 + n -1 , m-1)` 。

然而上面这个算式如果暴力求解，基本上随随便便就溢出了。我们人在算的时候，都是在约分的。所以如果直接算这个，可以通过不断约分的形式。

在[变态组合数C(n,m)求解](http://www.oschina.net/code/snippet_203297_11313)看到了不同的解决办法，不过没有细看。

我想我还是用动态规划算吧...

当然从这个角度去理解组合的意义，想想也是不错的——C(m-1 +n-1,m-1) = C(m-1 + n-2,m-1) + C(m-2+n-1,m-2) => `C(n,r) = C(n-1,r) + C(n-1,r-1)`;

## 代码

```C++
class Solution {
public:
    int uniquePaths(int m, int n) {
        if(0 == m || n == 0) return 0 ;
        vector<vector<int>> M(m , vector<int>(n,1)) ;
        for(size_t i  = 1 ; i < m ; ++i)
        {
            for(size_t j = 1 ; j < n ; ++j)
            {
                M[i][j] = M[i-1][j] + M[i][j-1] ;
            }
        }
        return M[m-1][n-1];
    }
};
```
