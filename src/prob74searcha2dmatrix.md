# problem 74. Search a 2D Matrix

[题目链接](https://leetcode.com/problems/search-a-2d-matrix/)

## 方法

对于这道题，有两种方法，时间复杂度都是O(log mn).

第一种是把矩阵拉通称为一个向量。唯一需要做的就是flat的Index到矩阵Index的转换了，在viterbi算法中常做这个，因此不难。

第二种就是先找到目标可能所在的行，然后在所在的行中再找（只能是先找行，再找列）。这是因为每行第一个是当前行最小的值，所以如果某两相邻行分别比目标小、大，那么目标就一定在小的那一行上（如果存在），此外还有等于的情况。为了统一表示，我们求uppper_bound，即第一列中第一个比目标大的，这样其前一行就必然是目标行了。然后再在对应行上找就OK了。这个时间复杂度是O(logm + logn) = O(log mn), 感觉让我复习了一下对数的运算。


## 代码

两种都写了，毕竟这种代码必须得会啊。贴上先找行，再找列的。

```C++
class Solution {
public:
    bool searchMatrix(vector<vector<int>>& matrix, int target) {
        size_t nrRow = matrix.size();
        if(nrRow == 0){ return false; }
        size_t nrCol = matrix[0].size();
        // first find the upper bound in 1st col
        int low = 0,
            high = nrRow - 1;
        while(low <= high)
        {
            int mid = low + (high - low) / 2;
            if(matrix[mid][0] <= target){ low = mid + 1;}
            else{ high = mid - 1; }
        }
        if(low == 0)
        {
            // all is bigger than target
            return false;
        }
        int searchRowId = low - 1;
        // binary search
        low = 0;
        high = nrCol - 1;
        while(low <= high)
        {
            int mid = low + (high - low) / 2;
            if(matrix[searchRowId][mid] < target){ low = mid + 1;}
            else{ high = mid - 1; }
        }
        return low != nrCol && matrix[searchRowId][low] == target;
    }
};
```