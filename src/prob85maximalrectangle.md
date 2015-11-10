###problem 85 Maximal Rectangle

[link](https://leetcode.com/problems/maximal-rectangle/)

这道题间隔了太久，从开始信心满满，以为要一次成功了，结果测试失败。才认真审视自己的想法，发现存在太大的问题。看了题解，又发现这解题太过高深，不是自己能够想出来的。所以网上找了一些题解。

发现了这个：[Maximal Rectangle](http://www.bkjia.com/cjjc/977261.html)

发现正确的动态规划思路，也找到了所谓的栈方法。感觉有些难啊，所以要好好地学。

###方法

动态规划方法，定义优化子结构A[i,j]表示以[0,0]为左上角，[i,j]为右下角的**矩形区域中包含的全为1的矩形的最大面积**。注意，是该区域内包含的最大面积！（之前在这里弄错了，错误的设计了优化子结构！）

则优化子结构的递推式可以写为： 

```C++
A[i,j] = max(A[i-1,j] , A[i,j-1] , 以Matrix[i][j]为右下角元素的最大矩形面积 )
```

首先，上面的递推式是可以做到完全覆盖的。这是优化子结构的必须满足的条件！

其次，关于`以Matrix[i][j]为右下角元素的最大矩形面积`的求取方法。链接的题解中先尝试了直接暴力搜，然后说可以做一些记录。我写的时候采用了直接搜的方法，结果耗时104ms，时间排名当然也是非常靠后的。

写这段代码也非常难受，写错了好多个地方。逻辑判断上错误百出，看来真的要好好练习下编码了。**一定要保证逻辑的一致性，这是编码中需要注意的问题。一个条件退出时，你必须要知道它是因为何种情况退出的。如果所有情况的处理都相同，那么就直接处理；否则，要么加入一些状态标识或者检查一些变量值，来判断退出的原因，要么就该逻辑——因为有时可能是你的逻辑出现了问题，才导致退出原因不确定。**

```C++
class Solution {
public:
    int maximalRectangle(vector<vector<char>>& matrix) {
        // check size
        int rows = matrix.size() ;
        if(rows == 0) return 0 ;
        int cols = matrix[0].size() ;
        if(cols == 0) return 0 ; // In fact , it shold not be 0 ;
        // maxArea(i,j) stands for the max area in the matrix (0,0) -> (i,j)
        vector<vector<int> > maxArea(rows , vector<int>(cols , 0)) ; 
        
        // init 
        // init (0,0)
        if(matrix[0][0] == '1') maxArea[0][0] = 1 ;
        for(int row = 1 ; row < rows ; ++row){
            if(matrix[row][0] == '0') maxArea[row][0] = maxArea[row-1][0];
            else
            {
                int up_coo = row ; // [up_coo][0] is the highest position which up_coo -> row is all '1'
                while(up_coo - 1 >= 0 && matrix[up_coo - 1][0] == '1') --up_coo ;
                maxArea[row][0] = max(row - up_coo + 1 , maxArea[row-1][0] );
            }
        }
        for(int col = 1 ; col < cols ; ++col){
            if(matrix[0][col] == '0') maxArea[0][col] = maxArea[0][col-1] ;
            else{
                int left_coo = col ;
                while((left_coo - 1>= 0 ) && (matrix[0][left_coo - 1] == '1')) --left_coo ;
                maxArea[0][col] = max(col - left_coo + 1 , maxArea[0][col-1]) ;
            }
        }
        
        // Dynamic Programing : left -> right , up -> down
        for(int row = 1 ; row < rows ; ++row){
            for(int col = 1 ; col < cols ; ++col ){
                if(matrix[row][col] == '0') maxArea[row][col] = max(maxArea[row-1][col] , maxArea[row][col-1]) ;
                else{
                    // calc the area with matrix[row][col] as the right down corner .
                    int left_coo = col ; 
                    int max_area_with_this = 0 ;
                    while(true)
                    {
                        // find max height 
                        int up_coo = row  ; 
                        while(true){
                            // test row `up_coo -1`
                            if(up_coo - 1 < 0) break ;
                            // check if is all '1' for row up_coo
                            bool is_all_1 = true ;
                            for(int j = left_coo ; j <= col ; ++j){
                                if(matrix[up_coo-1][j] == '0'){
                                    is_all_1 = false ;
                                    break ;
                                }
                            }
                            if(!is_all_1) break ;
                            else --up_coo ;
                        }
                        int area = ( col - left_coo + 1 ) * (row - up_coo + 1) ;
                        if(area > max_area_with_this) max_area_with_this = area ;
                        // check left col 
                        if(left_coo - 1 >= 0 && matrix[row][left_coo - 1] == '1') -- left_coo ;
                        else break ;
                    }
                    maxArea[row][col] = max( max(maxArea[row-1][col] , maxArea[row][col-1]) , max_area_with_this) ;
                }
            }
        }
        return maxArea[rows-1][cols-1] ;
    }
};
```

很容易想到针对上面的一个优化，就是使用动态规划的方法保存每个位置向上的连续1的数量，这样就不必一层一层的确认是否都为1了——>可以直接取min高度即为最大构成矩形的高度。后来又突然想到，不用每次都for循环一遍去找该区域的最小值，可以只算本次新加行的高度与之前最小高度的最小值即可。

完了，上面感觉完全说不清楚，还是代码好看懂：

```C++
class Solution {
public:
    int maximalRectangle(vector<vector<char>>& matrix) {
        // check size
        int rows = matrix.size() ;
        if(rows == 0) return 0 ;
        int cols = matrix[0].size() ;
        if(cols == 0) return 0 ; // In fact , it shold not be 0 ;
        // maxArea(i,j) stands for the max area in the matrix (0,0) -> (i,j)
        vector<vector<int> > maxArea(rows , vector<int>(cols , 0)) ; 
        vector<vector<int> > maxHeight(rows , vector<int>(cols , 0)) ;
        // init 
        // init (0,0)
        if(matrix[0][0] == '1'){
            maxArea[0][0] = 1 ;
            maxHeight[0][0] = 1 ;
        } 
        for(int row = 1 ; row < rows ; ++row){
            if(matrix[row][0] == '0') maxArea[row][0] = maxArea[row-1][0];
            else
            {
                int up_coo = row ; // [up_coo][0] is the highest position which up_coo -> row is all '1'
                while(up_coo - 1 >= 0 && matrix[up_coo - 1][0] == '1') --up_coo ;
                maxArea[row][0] = max(row - up_coo + 1 , maxArea[row-1][0] );
                maxHeight[row][0] = maxHeight[row-1][0] + 1 ;
            }
        }
        for(int col = 1 ; col < cols ; ++col){
            if(matrix[0][col] == '0') maxArea[0][col] = maxArea[0][col-1] ;
            else{
                int left_coo = col ;
                while((left_coo - 1>= 0 ) && (matrix[0][left_coo - 1] == '1')) --left_coo ;
                maxArea[0][col] = max(col - left_coo + 1 , maxArea[0][col-1]) ;
                maxHeight[0][col] = 1 ;
            }
        }
        
        // Dynamic Programing : left -> right , up -> down
        for(int row = 1 ; row < rows ; ++row){
            for(int col = 1 ; col < cols ; ++col ){
                if(matrix[row][col] == '0') maxArea[row][col] = max(maxArea[row-1][col] , maxArea[row][col-1]) ;
                else{
                    maxHeight[row][col] = maxHeight[row-1][col] + 1 ;
                    // calc the area with matrix[row][col] as the right down corner .
                    int left_coo = col ; 
                    int max_area_with_this = 0 ;
                    int min_height = numeric_limits<int>::max() ;
                    while(true)
                    {
                        // find max height => in fact , to get the min height of every col 
                        min_height = min(min_height , maxHeight[row][left_coo]) ;
                        int area = ( col - left_coo + 1 ) * min_height ;
                        if(area > max_area_with_this) max_area_with_this = area ;
                        // check left col 
                        if(left_coo - 1 >= 0 && matrix[row][left_coo - 1] == '1') --left_coo ;
                        else break ;
                    }
                    maxArea[row][col] = max( max(maxArea[row-1][col] , maxArea[row][col-1]) , max_area_with_this) ;
                }
            }
        }
        for(int i = 0 ; i < rows ; ++i)
        {
            for(int j = 0 ; j < cols ; ++j)
                cout << maxHeight[i][j] << " " ;
            cout << endl ;
        }
            
        return maxArea[rows-1][cols-1] ;
    }
};
```

最关键的改动就是：

```C++
while(true)
{
    // find max height => in fact , to get the min height of every col 
    min_height = min(min_height , maxHeight[row][left_coo]) ;
    int area = ( col - left_coo + 1 ) * min_height ;
    if(area > max_area_with_this) max_area_with_this = area ;
    // check left col 
    if(left_coo - 1 >= 0 && matrix[row][left_coo - 1] == '1') --left_coo ;
    else break ;
}

```
其中`min_height = min(min_height , maxHeight[row][left_coo]) ;`这一行，开始也是用for循环找的，不过后来想到其实可以直接这样二元的比就可以。

代码中`maxHeight[row][0] = maxHeight[row-1][0] + 1 ;`开始写成了`maxHeight[row][0] = maxArea[row-1][0] + 1 ;`，还是通过打LOG找到的。真的是要哭了。

不过终于知道LeetCode原来是可以直接输出的！！输出结果会显示在`stdout`栏，对最终结果也毫不影响，体验实在是太好了。

不过这样改后，时间竟然增加到了424ms！怀疑是打log和多分配一块内存的原因，删除log部分，时间为28ms！果然一下子就提升上去了！！看来打LOG时间开销还是太大了。这样一下子就beats 35.69%的提交了。

然而栈方法又是怎么做的呢？还需要继续学习！ 