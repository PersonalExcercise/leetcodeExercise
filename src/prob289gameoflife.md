# problem 289. Game of Life

[题目链接](https://leetcode.com/problems/game-of-life/)

## 方法

又学到一招，原来说in-place时还可以考虑把新状态放到二进制位里。这个在优化空间时是可以用到的，但是想不到这道题也需要用到。

## 代码

```C++
class Solution {
public:
    void gameOfLife(vector<vector<int>>& board) {
        int nrRow = board.size();
        if(nrRow == 0){ return ;}
        int nrCol = board[0].size();
        // get new state and storing in the second bit
        for(int i = 0; i < nrRow; ++i)
        {
            for(int j = 0; j < nrCol; ++j)
            {
                int neighborLiveCnt = countLiveCell(board, nrRow, nrCol, i, j);
                bool nextToLive = false; 
                if( board[i][j] == 1)
                {
                    if(neighborLiveCnt == 2 || neighborLiveCnt == 3){ nextToLive = true; }
                }
                else
                {
                    if(neighborLiveCnt == 3){ nextToLive = true; }
                }
                setNewState(board, i, j, nextToLive);
            }
        }
        // update state
        for(int i = 0; i < nrRow; ++i)
        {
            for(int j = 0; j < nrCol; ++j){ board[i][j] >>= 1; }
        }
    }
private:
    int countLiveCell(const vector<vector<int>> &board, int nrRow, int nrCol, int row, int col)
    {
        int cnt = 0;
        if(row > 0)
        {
            if(col > 0 && isLive(board, row-1, col-1)){ ++cnt; }
            if(isLive(board, row-1, col)) { ++cnt; }
            if(col + 1 < nrCol && isLive(board, row-1, col+1)){ ++cnt; }
        }
        if(col > 0 && isLive(board, row, col-1)){ ++cnt; }
        if(col < nrCol-1 && isLive(board, row, col+1)){ ++cnt; }
        if(row + 1 < nrRow)
        {
            if(col > 0 && isLive(board, row+1, col-1)){ ++cnt; }
            if(isLive(board, row+1, col)) { ++cnt; }
            if(col + 1< nrCol && isLive(board, row+1, col+1)){ ++cnt; }
        }
        return cnt;
    }
    bool isLive(const vector<vector<int>> &board, int row, int col)
    {
        // we should get origin state
        return board[row][col] & 0x1;
    }
    void setNewState(vector<vector<int>> &board, int row, int col, bool nextToLive)
    {
        if(nextToLive){ board[row][col] |= 0x2; }
    }
};
```