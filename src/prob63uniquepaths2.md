# problem 63. Unique Paths II

[link](https://leetcode.com/problems/unique-paths-ii/)

## 方法

如果说[Unique Path I](prob62uniquepaths.md)还会考虑直接用组合数的方法去做的话（虽然并不会很简单），加入了障碍后，这道题才真正有了动态规划的优势。

相比之下，有以下两点：

1. 边界上，从原点分别向右和向下初始化边界，只要未遇到1，则将方法数初始为1；如果遇到1，则说明有障碍，后面都不能再通过，初始化为0；

2. DP过程，如果位置值为1，则说明有障碍，不能通过，方法数为0；否则，依然是左方和上方的方法和。

## 代码

```C++
class Solution {
public:
    int uniquePathsWithObstacles(vector<vector<int>>& obstacleGrid) {
        size_t nrRow = obstacleGrid.size();
        if(0 == nrRow) return 0;
        size_t nrCol = obstacleGrid[0].size();
        vector<vector<int>> R(nrRow, vector<int>(nrCol));
        // edge init
        int colIdx = 0 ;
        while(colIdx < nrCol && obstacleGrid[0][colIdx] != 1){ R[0][colIdx++] = 1 ; }
        while(colIdx < nrCol) R[0][colIdx++] = 0;
        int rowIdx = 0;
        while(rowIdx < nrRow && obstacleGrid[rowIdx][0] != 1){ R[rowIdx++][0] = 1; }
        while(rowIdx < nrRow) R[rowIdx++][0] = 0;
        // DP
        for(rowIdx = 1 ; rowIdx < nrRow; ++rowIdx)
        {
            for(colIdx = 1; colIdx < nrCol; ++colIdx)
            {
                if(obstacleGrid[rowIdx][colIdx] == 1)
                {
                    R[rowIdx][colIdx] = 0 ;
                }
                else
                {
                    R[rowIdx][colIdx] = R[rowIdx-1][colIdx] + R[rowIdx][colIdx-1];
                }
            }
        }
        return R[nrRow-1][nrCol-1];
    }
};
```