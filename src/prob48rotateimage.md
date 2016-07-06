# problem 48. Rotate Image

[题目链接](https://leetcode.com/problems/rotate-image/)

## 方法

新开空间的方法，就是把第一行放到第一列上。没什么难度，不过发现也可以把逆向第一列放到结果第一行，依次下来也可。

原地的方法，瞎算一下，发现先按`/`对角线交换，然后再按行反转，就实现顺时针90度交换了。

这个题在之前CSP考试时做过，第一道题。想不到是Medium，又算是水一道。


## 代码

```C++
class Solution {
public:
    void rotate(vector<vector<int>>& matrix) {
        int nrRow = matrix.size();
        if(0 == nrRow){ return ; }
        int nrCol = matrix[0].size();
        // assert(nrRow == nrCol);
        // 1. swap following diagonal => `/`
        for(int i = 0; i < nrRow - 1; ++i)
        {
            int rotatedCol = nrCol - i - 1;
            for(int j = 0; j < nrCol - i; ++j)
            {
                swap(matrix[i][j], matrix[nrRow - j - 1][rotatedCol]) ; 
            }
        }
        // 2. reverse by row
        int headRow  = 0, rearRow = nrRow - headRow - 1;
        while(headRow < rearRow)
        {
            swap(matrix[headRow++], matrix[rearRow--]);
        }
    }
};
```
