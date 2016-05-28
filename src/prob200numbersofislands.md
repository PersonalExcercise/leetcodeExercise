###problem 200. Number of Islands 

[link](https://leetcode.com/problems/number-of-islands/)


## 方法

太菜了.. 一开始竟然尝试用循环去标记所有连续的1，然后发现不太好弄后又尝试只找当前的行和列，但是几次提交均发现不对，说明必须找到所有连续的1！

然后才发现应该要递归找啊！然后才把这个题抽象成找连通路径的问题... 真是不知道问题的根源啊...

然后就是DFS或者BFS了，栈是DFS，队列是BFS。

最后，我使用了一个额外的数组来存储各位置是否被访问。其实，可以直接修改原数组各位置的值，将1改为0即可。

## 代码

```C++
class Solution {
public:
    int numIslands(vector<vector<char>>& grid) {
        size_t nrRow = grid.size() ;
        if(0 == nrRow) return 0 ;
        size_t nrCol = grid[0].size() ;
        int nrIslands = 0 ;
        vector<vector<bool>> visited(nrRow, vector<bool>(nrCol, false)) ;
        for(size_t i = 0; i < nrRow; ++i)
        {
            for(size_t j = 0; j < nrCol; ++j)
            {
                if(visited[i][j]) continue;
                if('0' == grid[i][j]) continue;
                ++nrIslands;
                // find all connected path
                stack<pair<size_t,size_t>> s ;
                s.push({i, j});
                while(!s.empty())
                {
                    pair<size_t, size_t> &node = s.top() ;
                    size_t row = node.first,
                           col = node.second;
                    visited[row][col] = true;
                    s.pop();
                    if(row > 0 && grid[row-1][col] == '1' && !visited[row-1][col])
                    {
                        s.push({row-1, col});
                    }
                    if(row + 1 < nrRow && grid[row+1][col] == '1' && !visited[row+1][col])
                    {
                        s.push({row+1,col});
                    }
                    if(col > 0 && grid[row][col-1] == '1' && !visited[row][col-1])
                    {
                        s.push({row, col-1});
                    }
                    if(col + 1 < nrCol && grid[row][col+1] == '1' && !visited[row][col+1] )
                    {
                        s.push({row, col+1});
                    }
                }
            }
        }
        return nrIslands;
    }
};
```