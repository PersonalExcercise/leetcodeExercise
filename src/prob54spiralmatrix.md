# problem 54. Spiral Matrix

[题目链接](https://leetcode.com/problems/spiral-matrix/)

## 方法

嗯，其实还是比较简单的题，不过就是可能写起来不那么舒服。简单是因为直观，不舒服是边界控制。不过，还是不复杂的。

维护一个border，表示边界宽度，然后算出左上角和右下角的坐标就好了。一定要在纸上画出来（并标号变量名），不然容易晕。

需要注意的是，当向左和向上读取时，需要判断此时是不是只有一行或者只有一列，因为如果只有一行或一列的话，相应的操作会导致重复读取该行或该列。


## 代码

```C++
class Solution {
public:
    vector<int> spiralOrder(vector<vector<int>>& matrix) {
        int nrRow = matrix.size();
        if(0 == nrRow){ return {}; }
        int nrCol = matrix.back().size();
        vector<int> result(nrRow * nrCol);
        int borderMaxWidth = (min(nrRow, nrCol) + 1)/ 2;
        int pntCnt = 0;
        for(int borderWidth = 0; borderWidth < borderMaxWidth; ++borderWidth)
        {
            /**
               |
             ----------> X
               |
               |
               |
              Y.
            */
            int topLeftPntX = borderWidth,
                topLeftPntY = borderWidth;
            int bottomRightPntX = nrCol - borderWidth - 1,
                bottomRightPntY = nrRow - borderWidth - 1;
            // ---> right
            for(int j = topLeftPntX; j <= bottomRightPntX; ++j)
            {
                result[pntCnt++] = matrix[topLeftPntY][j];
            }
            // | down
            for(int i = topLeftPntY + 1; i <= bottomRightPntY; ++i)
            {
                result[pntCnt++] = matrix[i][bottomRightPntX];
            }
            // <--- left
            if(bottomRightPntY == topLeftPntY){ break; } // if only one row, finished.
            for(int j = bottomRightPntX - 1; j >= topLeftPntX; --j)
            {
                result[pntCnt++] = matrix[bottomRightPntY][j];
            }
            // | up
            if(topLeftPntX == bottomRightPntX){ break; } // if only one col, finished.
            for(int i = bottomRightPntY - 1; i > topLeftPntY; --i )
            {
                result[pntCnt++] = matrix[i][topLeftPntX];
            }
        }
        return result;
    }
};
```