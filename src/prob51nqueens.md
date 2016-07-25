# problem 51. N-Queens

[题目链接](https://leetcode.com/problems/n-queens/)

## 方法

据说，嗯，在知乎上看到的，某家公司面试的时候，大老板要求——10行代码内写个八皇后！

然后看到后面好多人写的... 要是我，一定淡定起身，说："抱歉，我与贵司的价值观不服！"　哈哈哈哈，ＹＹ得我好开心...

咳，回到问题本身，首先要明白八皇后问题的规则吧：

[维基百科](https://zh.wikipedia.org/wiki/%E5%85%AB%E7%9A%87%E5%90%8E%E9%97%AE%E9%A2%98)说得很清楚了，讲重点，就是： 每行、每列，每条对角线，皇后都可以攻击。要保证各个皇后间不能相互攻击才行——女人好厉害的样子啊...

深度搜索即可。

具体地，逐行搜索，在每个位置测试当前位置是否可放置皇后——所以我们需要维护三个状态表（因为我们逐行搜索，所以保证了行肯定不会冲突），分别是列(n个)、主对角线(2n-1个)、反对角线(2n-1)个。

注意主对角线是指`/`， 满足在一条对角线的 `row + col`值相等; 一条反对角线上的值满足 `col - row`相等（因为col-row可能为负，所以应该加上偏移 n-1）.


## 代码

```C++
class Solution {
private:
    struct State
    {
        vector<bool> colState;
        vector<bool> diagState;
        vector<bool> backDiagState;
        int n;
        State(int n) 
            : colState(n, false), diagState(n, false), backDiagState(n, false), n(n)
        {}
        bool isValid(int row, int col) const
        {
            return !colState[col] && !diagState[row+col] && !backDiagState[col-row+n-1];
        }
        void setState(int row, int col)
        {
            colState[col] = diagState[row + col] = backDiagState[col - row + n - 1] = true;
        }
        void resetState(int row, int col)
        {
            colState[col] = diagState[row + col] = backDiagState[col - row + n - 1] = false;
        }
    };
public:
    vector<vector<string>> solveNQueens(int n) {
        vector<vector<string>> result;
        vector<string> oneSolution(n, string(n, '.'));
        State state(n);
        solveNQueensRecursively(result, oneSolution, n, 0, state);
        return result;
    }
private:
    void solveNQueensRecursively(vector<vector<string>> &result, vector<string> &currentSolution, 
                                 int n, int row,
                                 State &state)
    {
        if(row == n)
        {
            // a valid solution
            result.push_back(currentSolution);
            return;
        }
        for(int col = 0; col < n; ++col)
        {
            if(state.isValid(row, col))
            {
                // update state
                state.setState(row, col);
                currentSolution[row][col] = 'Q';
                // solve recursively
                solveNQueensRecursively(result, currentSolution, n, row+1, state);
                // restore state
                state.resetState(row, col);
                currentSolution[row][col] = '.';
            }
        }
    }
};
```