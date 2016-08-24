# problem 10. Regular Expression Matching

[题目链接](https://leetcode.com/problems/regular-expression-matching/)

## 方法

初始时发现这怎么跟[wildcard matching](https://leetcode.com/problems/wildcard-matching/)一模样啊。

写完提交才发现，妈蛋，一个是正则匹配，一个通配符，规则不一样啊！学艺不精、马虎大意。

正则表达式中，`*`表示数量词修饰（注意是修饰符，表示前面的字符出现任意次），`·`代表任意一个字符。

通配符匹配中，`*`表示任意字符串（注意是字符串），`?`代表一个字符。

二者真的是不一样的！正则中也有`?`， 同样表示数量修饰（0或1次）。

最后，虽然规则变了，然后思想其实完全一样啦。之前是根据`*`来代表任意字符，而现在是根据`*`来表示当前之前的字符可出现多少次。为了方便， 我直接把`*`提取了出来，将非`*`字符作为匹配字符串，并且根据原始pattern串中`*`的位置确定每个位置的控制符标志。如果原始字符后面有`*`，则表示当前字符带控制标志，那么可以进行`{不匹配、匹配一个、匹配多个}`的选择.

最后，还是要说动态规划的时间复杂度，其实是把每个长度的pattern都与每个长度的待匹配串做了比较（但每次比较时O(1)）的，所以时间复杂度是O（(m+1) * (n+1)）, `+1`是因为我们需要额外各自考虑空串的情况。

## 代码

```C++
class Solution {
public:
    bool isMatch(string s, string p) {
        int sLen = s.size();
        string patternNoCtrl;
        vector<bool> ctrlState;
        processingPattern(p, patternNoCtrl, ctrlState);
        int pLen = patternNoCtrl.size();
        // M[i][j] stands for s.substr(0, i) Match p.substr(0,j) state.
        vector<vector<bool>> M(sLen + 1, vector<bool>(pLen + 1));
        initMatchMatrix(M, ctrlState);
        for(int i = 1; i < sLen + 1; ++i)
        {
            for(int j = 1; j < pLen + 1; ++j)
            {
                if(ctrlState[j-1])
                {
                    if(patternNoCtrl[j-1] == '.')
                    {
                        M[i][j] = M[i][j-1] // 0
                                  || M[i-1][j-1] // 1
                                  || M[i-1][j]; // 1+
                    }
                    else
                    {
                        M[i][j] = M[i][j-1] // 0
                                  || (M[i-1][j-1] && s[i-1] == patternNoCtrl[j-1]) // 1
                                  || (M[i-1][j] && s[i-1] == patternNoCtrl[j-1]); // 1+
                    }
                }
                else
                {
                    if(patternNoCtrl[j-1] == '.'){ M[i][j] = M[i-1][j-1]; }
                    else{ M[i][j] = (s[i-1] == patternNoCtrl[j-1]) && M[i-1][j-1]; }
                }
            }
        }
        return M[sLen][pLen];
    }
private:
    void processingPattern(const string &p, string &patternNoCtrl, vector<bool> &ctrlState)
    {
        string patternNoCtrlTmp;
        vector<bool> ctrlStateTmp;
        for(auto &c : p)
        {
            if(c != '*')
            {
                patternNoCtrlTmp.push_back(c);
                ctrlStateTmp.push_back(false); // push one init control state(false)
            }
            else
            {
                ctrlStateTmp.back() = true; // set previous state = true
            }
        }
        swap(patternNoCtrl, patternNoCtrlTmp);
        swap(ctrlState, ctrlStateTmp);
    }
    void initMatchMatrix(vector<vector<bool>> &M, const vector<bool> &ctrlState)
    {
        M[0][0] = true;
        int nrRow = M.size(),
            nrCol = M.back().size();
        // M[i][0], i >  0
        // s.substr(0, i) Match Empty Pattern , all false
        for(int i = 1; i < nrRow; ++i){ M[i][0] = false; }
        // M[0][j] , j > 0
        // Empty str match Pattern , except the continues control symbol(*)
        int j = 1;
        while(j < nrCol)
        {
            if(!ctrlState[j-1]){ break; }
            M[0][j] = true;
            ++j;
        }
        while(j < nrCol){ M[0][j++] = false; }
    }
};
```