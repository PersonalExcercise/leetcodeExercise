###problem [120] [Triangle]

[link](https://leetcode.com/problems/triangle/)

###方法

比较明显的动态规划问题。

直观上当然是从上往下找啦，选择的优化子问题跟维特比算法、最短路径、最大子数组和有些像，A\[i\]\[j\]表示到达第i行j列元素时的最小代价。由题意，这个包含A\[i-1\]\[j\]和A\[i-1\]\[j-1\]这两个子问题的解。

考虑递归式的时候，注意到，这个解表示起来是个下三角矩阵！第i行只有i列！

```C++
A[i][j] = min(A[i-1][j-1] , A[i-1][j]) + Cost[i][j] . if ( i >= 1 && j >= 1 && j <= i-1 ) 
A[i][j] = A[i-1][j] + Cost[i][j]  , if ( j = 0 & i != 0) // 列为0 ，上一行不会有j-1
A[i][j] = A[i-1][j-1] + Cost[i][j] , if( j == i && i != 0) //列为当前行最后一列，上一行不会有该列
A[i][j] = Cost[i][j] , if( i == 0 && j == 0) // A[0][0]
```

代码：

```C++
class Solution {
    public:
        int minimumTotal(vector<vector<int>>& triangle) {
            int rowNum = triangle.size() ;
            //int maxColNum = rowNum ;
            vector<vector<int> > minPathCost = vector<vector<int> >(rowNum , vector<int>(rowNum , 0 )) ;
            minPathCost[0][0] = triangle[0][0] ;
            for(int row = 1 ; row < rowNum ; ++row)
            {
                minPathCost[row][0] = minPathCost[row-1][0] + triangle[row][0] ;
                minPathCost[row][row] = minPathCost[row-1][row-1] + triangle[row][row] ;
                for(int col = 1 ; col <= row - 1 ; ++col)
                {
                    minPathCost[row][col] = min(minPathCost[row-1][col-1] , minPathCost[row-1][col]) + triangle[row][col] ;
                }
            }
            // find the minimum path cost
            int minCost = INF ;
            for(int i = 0 ; i < rowNum ; ++i)
            {
                if(minCost > minPathCost[rowNum-1][i])
                {
                    minCost = minPathCost[rowNum-1][i] ;
                }
            }
            return minCost ;
        }
    private :
        const int INF = 0xFFFFFF ; // 2^{24}
};
```

然后可试试考虑下从下往上！A\[i\]\[j\]表示由下往上到达该元素时的最小代价。这样一来有好处啊！

首先是当前的元素与下一行相邻元素间关系变得简单了，就是A\[i+1\]\[j\]和A\[i+1\]\[j+1\]，这两个元素不用再考虑j为0以及j为i时的情况了，变得清晰简单。

其次，到达最后时，就一个元素~ 不用再循环找最小值了！

写代码试验一下~

```C++
class Solution {
    public:
        int minimumTotal(vector<vector<int>>& triangle) {
            // From Down-To-Top
            int rowNum = triangle.size() ;
            vector<vector<int> > minPathCost(rowNum , vector<int>(rowNum)) ;
            // Init
            for(int col = 0 ; col < rowNum ; ++col)
            {
                minPathCost[rowNum-1][col] = triangle[rowNum-1][col] ;
            }
            // solving sub-problem
            for(int row = rowNum -2 ; row >= 0 ; --row)
            {
                for(int col = 0 ; col <= row ; ++col)
                {
                    minPathCost[row][col] = min(minPathCost[row+1][col] , minPathCost[row+1][col+1]) + triangle[row][col] ;
                }
            }
            // solving problem
            return minPathCost[0][0] ;
        }
    };
```

很好~ 结果一样！！ 而且代码、逻辑都变简单了！

这个真是思维的力量啊！！当然，这种想法是看的题解...

###空间优化

题目说如果是`O(n)`的空间会很好！想想，在上面的两种情况种，都是可以用一行个数为`N`的数组存储的——因为这个动态规划过程是一行一行算的嘛。

不过从上往下的方法时，下一行依赖上一行的对应列的前一个元素，压缩到一行来看，就是需要求前一次结果的前一个值，所以，我们还是需要搞一个临时变量来存一下。

```C++
class Solution {
    public:
        int minimumTotal(vector<vector<int>>& triangle) {
            int rowNum = triangle.size() ;
            //int maxColNum = rowNum ;
            vector<int> minPathCost = vector<int>(rowNum ,  0 ) ;
            minPathCost[0] = triangle[0][0] ;
            for(int row = 1 ; row < rowNum ; ++row)
            {
                int curRowPreColValue = minPathCost[0] + triangle[row][0] ;
                minPathCost[row] = minPathCost[row-1] + triangle[row][row] ;
                for(int col = 1 ; col <= row - 1 ; ++col)
                {
                    int curRowCurColValue = min(minPathCost[col-1] , minPathCost[col]) + triangle[row][col] ;
                    // update current row previous col value in the minPathCost
                    minPathCost[col-1] = curRowPreColValue ;
                    // update curRowPreVolValue
                    curRowPreColValue = curRowCurColValue ;
                }
                // update the current row 's `col-1` col (at the last , col = row)
                minPathCost[row-1] = curRowPreColValue ;
                
            }
            // find the minimum path cost
            int minCost = INF ;
            for(int i = 0 ; i < rowNum ; ++i)
            {
                if(minCost > minPathCost[i])
                {
                    minCost = minPathCost[i] ;
                }
            }
            return minCost ;
        }
    private :
        const int INF = 0xFFFFFF ; // 2^{24}
};
```

本以为优化了空间，减少了申请内存的开销，同时访问也仅仅加入了两个临时变量（`curRowPreColValue` , `curRowCurColValue`）时间应该减，然而...时间却从12ms跳到16ms，诶....其实是有些不理解的...

对于从下往上的情况，压缩到一行来看，就是当前的值仅与当前值与后面列的值有关，所以，不需添加任何临时变量！！非常简单。

```C++
class Solution {
    public:
        int minimumTotal(vector<vector<int>>& triangle) {
            // From Down-To-Top
            int rowNum = triangle.size() ;
            vector<int> minPathCost(rowNum , 0) ;
            // Init
            for(int col = 0 ; col < rowNum ; ++col)
            {
                minPathCost[col] = triangle[rowNum-1][col] ;
            }
            // solving sub-problem
            for(int row = rowNum -2 ; row >= 0 ; --row)
            {
                for(int col = 0 ; col <= row ; ++col)
                {
                    minPathCost[col] = min(minPathCost[col] , minPathCost[col+1]) + triangle[row][col] ;
                }
            }
            // solving problem
            return minPathCost[0] ;
    }
};
```

时间开销依然12ms，空间优化了。最后，还是这种方法最好。