# problem 52. N-Queens II

[题目链接](https://leetcode.com/problems/n-queens-ii/)

## 方法

做之前看了前前一个题，又有点忘了... 

八皇后问题，行、列、对角线、反对角线都不能攻击。注意对角线是一整条，而不是相邻！然后就是正反对角线编号。正对角线`row + col` , 反对角线`row - col + n - 1`.发现之前的代码写得挺好，不过有BUG（正反对角线个数应该是2n-1个，但是写成了n个，内存溢出了，如果用at就能检查出来了！这实在是大忌！！已经把它修改了...）

还是重新写了下，还是比较迅捷的。

## 代码

```C++
class QueueState
{
public:
    QueueState(int n) 
      : n(n), colValid(n, true), diagonalValid(2*n-1, true), backDiagonalValid(2*n-1, true)
    {}
    int getDiagonalIndex(int row, int col)
    {
        return row + col;
    }
    int getBackDiagonalIndex(int row, int col)
    {
        return row - col + n - 1;
    }
    bool isPosValid(int row, int col)
    {
        return colValid[col] && diagonalValid[getDiagonalIndex(row, col)] && backDiagonalValid[getBackDiagonalIndex(row, col)];
    }
    void occupy(int row, int col)
    {
        colValid[col] = false;
        diagonalValid[getDiagonalIndex(row, col)] = false;
        backDiagonalValid[getBackDiagonalIndex(row, col)] = false;
    }
    void release(int row, int col)
    {
        colValid[col] = true;
        diagonalValid[getDiagonalIndex(row, col)] = true;
        backDiagonalValid[getBackDiagonalIndex(row, col)] = true;
    }
    int getN(){ return n; }
private:
    int n;
    vector<bool> colValid;
    vector<bool> diagonalValid;
    vector<bool> backDiagonalValid;
};

class Solution {
public:
    int totalNQueens(int n) {
        QueueState state(n);
        int cnt = 0;
        countValidQueueState(cnt, state);
        return cnt;
    }
private:
    void countValidQueueState(int &cnt, QueueState &state, int row=0)
    {
        if(row == state.getN())
        {
            ++cnt;
            return;
        }
        for(int j = 0; j < state.getN(); ++j)
        {
            if(state.isPosValid(row, j))
            {
                state.occupy(row, j);
                countValidQueueState(cnt, state, row + 1);
                state.release(row, j);
            }
        }
    }
};
```