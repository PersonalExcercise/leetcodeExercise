# problem 59. Spiral Matrix II

[题目链接](https://leetcode.com/problems/spiral-matrix-ii/)

## 方法

与漩涡矩阵第一个题一样的...

## 代码

```C++
class Solution {
public:
    vector<vector<int>> generateMatrix(int n) {
        if(n <= 0){ return {}; }
        vector<vector<int>> result(n, vector<int>(n));
        int borderMaxWidth = ( n + 1) / 2;
        int num = 1;
        for(int borderWidth = 0; borderWidth < borderMaxWidth; ++borderWidth)
        {
            int topLeftX = borderWidth,
                topLeftY = borderWidth;
            int bottomRightX = n - 1 - borderWidth,
                bottomRightY = n - 1 - borderWidth;
            // left
            for(int j = topLeftX; j <= bottomRightX; ++j){ result[topLeftY][j] = num++; }
            // down
            for(int i = topLeftY + 1; i <= bottomRightY; ++i ){ result[i][bottomRightX] = num++;}
            // right
            if(topLeftY == bottomRightY){ break; }
            for(int j = bottomRightX - 1; j >= topLeftX; --j){ result[bottomRightY][j] = num++; }
            // up
            if(topLeftX == bottomRightX){ break; }
            for(int i = bottomRightY - 1; i > topLeftY; --i){ result[i][topLeftX] = num++; }
        }
        return result;
    }
};
```