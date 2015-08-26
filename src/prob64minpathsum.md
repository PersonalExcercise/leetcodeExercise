##problem 64 Minimun Path Sum

### [link](https://leetcode.com/problems/minimum-path-sum/)

### 方法

DP方法

建立m*n的矩阵M，对应M[i][j]表示到达该点的最小路径和；

1. 递推关系式
    
        D[i][j] = min( D[i-1][j] + grid[i][j] , //! downward
                       D[i][j-1] + grid[i][j]   //! rightward
                     ) // 边界条件未考虑

2. 初始值

        D[0][0] = grid[0][0]


3. 结果
    
        result = D[m-1][n-1]

### 代码

学习了二维vector的初始化：

    vector<vector<int> > v(m , vector<int>(n , 0) ) ; //! constructor : vector(num , init_value )
    // vector中包含vector，在C++11之前是需要在两个由尖括号间留一个空白；C++11中解决了这个问题。

[code]

    class Solution {
    public:
        int minPathSum(vector<vector<int>>& grid) {
            int nr_row = grid.size() , nr_col = grid[0].size() ;
            vector<vector<int> > minPathSumGrid(nr_row , vector<int>(nr_col , 0)) ;
            for(int i = 0 ; i < nr_row ; ++i)
            {
                for(int j = 0 ; j < nr_col ; ++j)
                {
                    if( i == 0)
                    {
                        if( j == 0)
                        {
                            minPathSumGrid[i][j] = grid[i][j] ;
                        }
                        else
                        {
                            minPathSumGrid[i][j] = minPathSumGrid[i][j-1] + grid[i][j] ;
                        }
                    }
                    else
                    {
                        if( j == 0)
                        {
                            minPathSumGrid[i][j] = minPathSumGrid[i-1][j] + grid[i][j] ; 
                        }
                        else 
                        {
                            minPathSumGrid[i][j] = min(minPathSumGrid[i-1][j] + grid[i][j] , minPathSumGrid[i][j-1] + grid[i][j] ) ;
                        }
                    }
                }
            }
            return minPathSumGrid[nr_row-1][nr_col-1] ;
        }
    };



### 相关

看到一个题目：

m*n的格子，从左下到右上，只能向右和向上，一共有多少走法？

解答：可以这样来看。从左下到右上，必然要走（m-1） + （n-1）步 ， 这些步中，随机选（m-1）步向上，其余均向右（反过来选择向右也一样），故有从（m+n-1）中选择（m-1）种（或者n-1，都一样）方法。

如果要限制不能经过某一个点，如P（k，l）点，那么我们先算从左下到P点的可能，类似的有从（k+l -2）中选(k-1)种，然后计算从P点到右上的方法数，及从（m-k + n -l -2）中选（m-k-1）种。故去掉的方法数就是这两种方法数的乘积。

> 上述的数值可能存在问题。