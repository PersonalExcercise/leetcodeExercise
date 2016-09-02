# problem 36. Valid Sudoku

[题目链接](https://leetcode.com/problems/valid-sudoku/)

## 方法

直观的做就好了。

## 代码

```C++
class Solution {
public:
    bool isValidSudoku(vector<vector<char>>& board) {
        if(!validRow(board)){ return false; }
        if(!validCol(board)){ return false; }
        if(!validGrid(board)){ return false; }
        return true;
    }
private:
    bool validRow(const vector<vector<char>> &board)
    {
        bitset<9> isVisited;
        for(int i = 0; i < 9; ++i)
        {
            isVisited.reset();
            for(int j = 0; j < 9; ++j)
            {
                if(board[i][j] != '.')
                {
                    int val = board[i][j] - '0';
                    if(isVisited[val-1]){ return false; }
                    else{ isVisited[val-1] = true; }
                }
            }
        }
        return true;
    }
    bool validCol(const vector<vector<char>> &board)
    {
        bitset<9> isVisited;
        for(int j = 0; j < 9; ++j)
        {
            isVisited.reset();
            for(int i = 0; i < 9; ++i)
            {
                if(board[i][j] == '.') continue;
                int val = board[i][j] - '0';
                if(isVisited[val-1]){ return false; }
                else{ isVisited[val-1] = true; }
            }
        }
        return true;
    }
    bool validGrid(const vector<vector<char>> &board)
    {
        bitset<9> isVisisted;
        for(int i = 0;i < 3; ++i)
        {
            for(int j = 0; j < 3; ++j)
            {
                isVisisted.reset();
                int startRow = i * 3,
                    startCol = j * 3;
                for(int gi = startRow; gi < startRow + 3; ++gi)
                {
                    for(int gj = startCol; gj < startCol + 3; ++gj)
                    {
                        
                        if(board[gi][gj] == '.'){ continue; }
                        int val = board[gi][gj] - '0';
                        if(isVisisted[val-1]){ return false; }
                        else{ isVisisted[val-1] = true; }
                    }
                }
            }
        }
        return true;
        
    }
};
```