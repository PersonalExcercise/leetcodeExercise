# problem 221. Maximal Square

[题目链接](https://leetcode.com/problems/maximal-square/)

## 方法

这道题已经是第3遍做了，第一遍是算法作业，第二遍是算法考试，第三遍就是现在了。这是唯一一次真正把可运行代码写出来，终于代码验证了一遍。一次过，没有拼写错误！看来这道题真的是了熟于心了（算法能过，这道题功不可没啊,orz）。

我们用`R[i][j]`表示矩阵中以第i行第j列的小正方形为右下角的全为1的正方形最大边长。有点绕，分开来说，首先表示的是以此位置为由下脚的正方形，其次正方形里全部为1，最后是最大的。即

```XML
matrix[i][j]是正方形的右下角 && 正方形全部为1 && 正方形为最大

```

为什么这么定义？因为这么定义我们才能得到递归关系！类似的定义的题，有最大连续子数组和，用动态规划也得这么定义。**因为这样定义才有`连续`的性质在里面**。又恰恰是正方形！所以我们算是比较容易能够得到这样一个递推关系：

```C++

R[i][j] = 0 , if matrix[i][j] = 0
R[i][j] = min(R[i-1][j-1], R[i][j-1], R[i-1][j]) + 1 , if matrix[i][j] = 0

R[i][0] = 1 if matrix[i][0] = 1 , else 0
R[0][j] = 1 if matrix[0][j] = 1 , else 0

```

边界条件就不解释了。普通状态下，以`matrix[i][j]`为右下角的全为1的正方形，是分别以 matrix[i-1][j] , matrix[i][j-1] , matrix[i-1][j-1] 为右下角的三个正方形的并！可以在纸上画一下，能够很清晰看出来。不过 三个取min再加1似乎不太直观。+1很直观，因为加了一个角，边长增大1。取min？知道了取min还是很好解释的，三者取并，但是还得围成一个正方形啊！所以得取其中最小的边。还是纸上画个图就出来了。特别的，如果有一个为0，那么边长为1，就是自己本身（当matrix[i][j]为1时），这个是成立的。



## 代码

```C++
class Solution {
public:
    int maximalSquare(vector<vector<char>>& matrix) {
        size_t nrRow = matrix.size() ;
        if(0 == nrRow) { return 0 ;}
        size_t nrCol = matrix[0].size();
        
        int maxEdgeLen = 0 ;
        vector<vector<int>> R(nrRow, vector<int>(nrCol));
        
        // init
        for(size_t i = 0 ; i < nrRow; ++i)
        {
            if(matrix[i][0] == '0'){ R[i][0] = 0 ;}
            else { R[i][0] = 1 ; maxEdgeLen = 1; }
        }
        for(size_t j = 0; j < nrCol; ++j)
        {
            if(matrix[0][j] == '0'){ R[0][j] = 0 ; }
            else { R[0][j] = 1 ; maxEdgeLen = 1; }
        }
        // dp
        for(size_t i = 1 ; i < nrRow; ++i)
        {
            for(size_t j = 1; j < nrCol; ++j)
            {
                if(matrix[i][j] == '0'){ R[i][j] = 0 ;}
                else
                {
                    R[i][j] = min(R[i-1][j-1], min(R[i-1][j], R[i][j-1])) + 1 ;
                    maxEdgeLen = max(R[i][j], maxEdgeLen);
                }
            }
        }
        return maxEdgeLen * maxEdgeLen ;
    }
};
```

## 后记

12ms，不是最优的。值看了一个DISCUSS，发现递归式相同。即是，都是二阶的。注意，输入是一个矩阵，并非正方形。而我们的递归式，用三个角来表示，同时取min，保证得到的是一个正方形。还有一个类似的题，是求最大长方形的，那道题就没什么好的递推式了，会更复杂（我应该已经做过了...吧，当时好像用的暴力，稍微用了点DP，就是存了下最高的为1的高度，我记得使用栈方法是最优的...瞎说什么啊.STOP）。回到正题，我猜算法的复杂度没什么可优化的了，可能是空间优化了下。毕竟，DP过程不用存一个同样大小的矩阵（或者肯定有人直接用原矩阵了！这就是参数不是const的原因！不够我一直鄙视这样的做法，至于吗...）。用两个数组就可以了。这个优化就不写了...