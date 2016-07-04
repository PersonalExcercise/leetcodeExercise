# problem 73. Set Matrix Zeroes

[题目链接](https://leetcode.com/problems/set-matrix-zeroes/)

## 方法

这个问题很容易错误啊。

关键是，如果你直接原地清零，那么你就不能知道后面你遇到0时，是原来的0，还是你清零后带来的0？

所以，不得不做两遍。一遍来记录那个位置有0，一遍来清空行、列。

所以最直接的办法是建一个O(mn)布尔矩阵来记录。不巧的是直接看了提示，说可以用O(m+n)的空间——这个简单，因为是清空整行、列嘛，所以一直直接记录到行、列上就好了，没有必要记录到具体哪个格子上。

不过，不使用额外的空间怎么做？智障，又没明白。

看了题解，还是巧妙，也简单。

我们直接用每行、每列的第一个元素来分别表示O(m+n)的状态——即是该行、列否有0。如果该行、列第一个元素不是0，但是因为该行、列包含0，所以将其置零不会带来任何问题；如果其本身就是0，那么置零也是必须的。

不过有一个问题需要注意！就是0行0列这个值！这个值即可以表示第0行包含0元素，又可以表示第0列包含0元素。如果不处理就会造成错误（已错）。所以需要用一个额外的变量来表示其中一个状态。这里我们假设0行0列表示行的状态，所以额外的变量就用来表示第0列的状态。

最后，清除的过程，我们一定要逆序！因为如果我们直接从第0行开始清，那直接把所有状态全部抹掉了！列也是同理。

要把代码一次写对还真是不容易。如果有一点疑惑不清，我觉得就会错啊。像我这种看题解的人，看得不太清楚，错了几次。终于明白了...MDZZ。

## 代码

```C++
class Solution {
public:
    void setZeroes(vector<vector<int>>& matrix) {
        // do as 
        // https://discuss.leetcode.com/topic/5056/any-shortest-o-1-space-solution
        int nrRow = matrix.size();
        if(nrRow == 0){ return; }
        int nrCol = matrix[0].size();
        bool col0HasZero = false;
        for(int i = 0; i < nrRow; ++i)
        {
            if(matrix[i][0] == 0){ col0HasZero = true; }
            for(int j = 1; j < nrCol; ++j)
            {
                if(matrix[i][j] == 0)
                {
                    matrix[i][0] = 0;
                    matrix[0][j] = 0;
                }
            }
        }
        // clear
        for(int i = nrRow - 1; i >= 0; --i)
        {
            if(matrix[i][0] == 0)
            {
                for(int j = 1; j < nrCol; ++j)
                {
                    matrix[i][j] = 0;
                }
                continue;
            }
            for(int j = nrCol - 1; j > 0; --j)
            {
                if(matrix[0][j] == 0){ matrix[i][j] = 0; }
            }
            if(col0HasZero){ matrix[i][0] = 0; }
        }
        
    }
};
```