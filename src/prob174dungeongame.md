# problem 174. Dungeon Game

[link](https://leetcode.com/problems/dungeon-game/)

## 方法

标准DP问题，没有太大思考难度。不过还是在纸上画了一会了，写出了需要满足的条件，结果觉得还是直接直观理解更加简单。

明显需要倒推。

首先是最后一个格子。到达这个格子之前，K至少有1点HP，设当前地牢值为d，若当前地牢如果为战斗（d为负），设则为了保证战斗后剩余1，则至少需要的HP为d+1；如果为补药（d大于0），则只要需要HP为1。

接着是处理两边的边界，边界是任意情况的特例，故先考虑任意情况。

任意情况下，K可以往下或者往右。那么倒推时有时看该地牢右边和下面的至少需要的值。显然，取右边和下边相对较小的即可，该值就是在经过该地牢后至少需要保留的值，设为r。那么进入地牢时的值就是 r-d。如果d是正，则其有可能为负数，但为了保持存活，仍然至少为1。边界就是只能向下或向右的情况。

## 代码

```C++
class Solution {
public:
    int calculateMinimumHP(vector<vector<int>>& dungeon) {
        size_t nrRow = dungeon.size() ;
        if(0 == nrRow) return 1;
        size_t nrCol = dungeon[0].size();
        vector<vector<int>> minNeedMatrix(nrRow,vector<int>(nrCol));
        // init the P 
        minNeedMatrix[nrRow-1][nrCol-1] = max(1, 1 - dungeon[nrRow-1][nrCol-1]);
        // init last col
        for(int i = static_cast<int>(nrRow)-2 ; i >= 0 ; --i )
        {
            minNeedMatrix[i][nrCol-1] = max(1 , 
                                            minNeedMatrix[i+1][nrCol-1] - dungeon[i][nrCol-1]);
        }
        // init last row
        for(int j = static_cast<int>(nrCol)-2 ; j >= 0 ; --j)
        {
            minNeedMatrix[nrRow-1][j] = max(1, 
                                            minNeedMatrix[nrRow-1][j+1] - dungeon[nrRow-1][j]);
        }
        // iterate
        for(int j = nrCol-2 ;j >= 0 ; --j )
        {
            for(int i = nrRow -2 ; i >= 0 ; --i)
            {
                minNeedMatrix[i][j] = max(1 , 
                                          min(minNeedMatrix[i+1][j] , minNeedMatrix[i][j+1]) - 
                                          dungeon[i][j]);
            }
        }
        return minNeedMatrix[0][0];
    }
};
```
