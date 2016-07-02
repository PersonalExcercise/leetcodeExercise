# problem 79. Word Search

[题目链接](https://leetcode.com/problems/word-search/)

## 方法

已经服了。幸苦写个迭代版深搜，然而却超时了...

那种感觉，就是不得不放弃编程事业，只能安心搬砖的凄凉与欣慰。

为什么？首先，自己写错了好几次，终于发现，我在栈版的深搜时，不得不保持当前位置、搜索字符串的位置、以及访问状态矩阵。特别是状态矩阵，这需要不断地copy、释放，代价实在太大了。

相比之下，使用传引用的递归调用则没有这个开销，因而，函数调用的开销小于了频繁大块内存申请释放的开销，所以迭代TLE，而递归版通过。

为什么递归就能够恢复状态矩阵的状态，而迭代似乎就不能呢？

我觉得，是因为迭代时，当取出父亲节点时，就直接将其pop了。而在递归时，这个状态依然可以得到——我们可以在递归返回到当前状态时，将状态矩阵回复到之前设置的状态，然而迭代版却不能。

## 代码

```C++
class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        size_t nrRow = board.size();
        if(nrRow == 0){ return word.length() == 0; }
        size_t nrCol = board[0].size();
        if(nrCol == 0){ return word.length() == 0; }
        if(word.length() == 0){ return true; }
        
        vector<vector<bool>> isVisited(nrRow, vector<bool>(nrCol, false));
        for(size_t i = 0; i < nrRow; ++i)
        {
            for(size_t j = 0; j < nrCol; ++j)
            {
                if(word[0] == board[i][j])
                {
                    bool findState = findPath(board, word, i, j, 1, isVisited);
                    if(findState){ return true; }
                }
            }
        }
        return false;
    }
private :
    bool findPath(const vector<vector<char>> &board, const string &word, size_t row, size_t col, size_t searchPos, 
                  vector<vector<bool>> &isVisited)
    {
        if(searchPos == word.length()) { return true; }
        isVisited[row][col] = true;
        char searchChar = word[searchPos];
        bool searchState ;
        if(row > 0 && board[row-1][col] == searchChar && !isVisited[row-1][col])
        {
            searchState =  findPath(board, word, row-1, col, searchPos+1, isVisited);
            if(searchState){ return true; }
        }
        if(row+1 < board.size() && board[row+1][col] == searchChar && !isVisited[row+1][col])
        {
            searchState = findPath(board, word, row+1, col, searchPos+1, isVisited);
            if(searchState){ return true; }
        }
        if(col > 0 && board[row][col-1] == searchChar && !isVisited[row][col-1])
        {
            searchState = findPath(board, word, row, col-1, searchPos+1, isVisited);
            if(searchState){ return true; }
        }
        if(col +1 < board[0].size() && board[row][col+1] == searchChar && !isVisited[row][col+1])
        {
            searchState = findPath(board, word, row, col+1, searchPos+1, isVisited);
            if(searchState){ return true; }
        }
        // find faild
        isVisited[row][col] = false;
        return false;
    }
};
```

## 后记

深搜的话，递归深搜的话，其实就没有太大的意义了。