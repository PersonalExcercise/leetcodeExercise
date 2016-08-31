# problem 32. Longest Valid Parentheses

[题目链接](https://leetcode.com/problems/longest-valid-parentheses/)

## 方法

最优时间复杂度O(n)，有多种解法，自己一个也没有想到...

### 栈方法

使用栈，将不匹配的下标留在栈中，然后就可以用两个下标的间隔来表示匹配的序列的长度。求最长即可。

思路非常简单直观：

1. 建立存放索引的栈，从前往后处理字符串：

2. 如果当前索引的字符是'('，则直接将当前索引压栈；

3. 否则（当前字符是')'），如果 栈顶不空且栈顶元素是'('，那么这两个就是匹配的，弹栈栈顶元素；否则，要么栈为空，要么栈顶是')'，就是不匹配的，把当前索引压栈。

4. 如果没有处理完，则跳到1，否则到5。

5. 栈中存的是不匹配的下标。如果栈为空，说明全部比配，返回字符串长度。如果不为空，则初始末尾位置为len，计算末尾位置与栈顶索引间的距离，即为匹配字符串的长度，计算完一个后，只要栈顶不空，则将末尾位置更新为栈顶值，再弹栈，持续比较，记录其中的最大值。栈空后，还需要计算最后一个末尾位置与起始位置之前（-1）的距离。求最大。——这步写得比较复杂，其实就是迭代计算两个索引间的距离，因为栈中少了末尾和起始位置之前两个下标，故需要额外再处理下。

### 动态规划

非常巧妙的动态规划方法，用`M[i]`表示以位置`i`结尾的最长匹配串的长度（嗯，想想最大子数组和中的动态规划定义，都是一样的）。

以下是递推的思路：

1. 如果当前位置字符是`(`，那么以`(`结尾的必然不是匹配的序列。（一定要注意啊，我们动态规划的定义是以此位置结尾的最长匹配串，就是说这个位置的字符必然在匹配串里，而要以`(`结尾的字符串，必然是不匹配的，故以此结尾的最长匹配串长度为0；不要把定义弄错了，不是说以此结尾的子串中的最长匹配串，而是以此结尾的匹配串的最长串。）

2. 如果当前字符是`)`, 那么其可能是一个匹配串的结尾，以下逻辑确定其最大的长度：

    1. 如果当前下标为0，那么显然不匹配，为0
    2. 如果前一个字符是`(`,那么就与前一个字符匹配，则长度为： `M[i] = M[i-2] + 2 , i >= 2 ; M[i] = 2 , i == 1`, 即`(`前面匹配串的长度加上当前新加的匹配串长度(2).
    3. 如果前一个字符是`)`，那么我们根据`M[i-1]`可以得到以前面那个`)`结尾的匹配串长度，假设为L,则情况如下： `p x (---L---) )`，其中`(---L---)`就表示以前面`)` 结尾的最长匹配串，`x`是该字符串序列的前一个字符（位置），`p`是x的前一个字符（位置）。这时我们就要考察`x`位置的字符了： 如果`x`位置字符是`(`，OK，完美匹配，那么以此位置结尾的匹配字符串最大长度是`M[i] = M[i-2-L] + M[i-1] + 2 , i >= 2; M[i] = 0, i < 2`(其实`i==2`时根本不可能出现这种情况!这里仅从下标合法性考虑了), 其中`i-L-2`就是`p`的下标; 如果`x`是`)`，完蛋，不匹配，则`M[i] = 0`.

    其实对于第3种的最后一个可能，即`x`位置是`)`时不匹配的论断，我起初很有疑惑，觉得这怎么可能就说不匹配呢？万一前面还有`(`呢？后来举了个例子，发现根本不可能—— 如果前面有`(`，那么其与`p`处的`)`间构成的串就必然是匹配的，*那么其必然就会包含在`M[i-1]`里*，想想是不是呢？因为`M[i-1]`表示的可是最长啊，而`p`又与此连续。因此，上面的假设是不可能成立的。即是说，`p`处为`)`时，必然是一个不匹配的串，否则就会被包含在前一个字符的最长匹配串里面。

这个还是有点难的，虽然写出来觉得也能理解，然而这毕竟是看了答案啊！！

### 双向处理

1. 正向，初始未匹配左括号数为0，初始匹配串起始下标为0；正向遍历，如果当前字符是`(`，则递增未匹配左括号计数；如果是`)`，则递减未匹配左括号数，检查是否小于0（起始等价于是否等于-1），如果小于0，则说明已经不匹配了，根据起始下标count一下长度`L = i - start`, `i`是当前下标，并更新起始下标为`i+1`； 这可以处理右括号多的情况，如： `()))`

2. 反向，与上面同理，只是先匹配`)`，再匹配`(`. 可以处理左括号多的情况： `((()`

有了正向最长和反向最长，再求其中最长的，那么就是整个串最长的。写得不算很完善，请看代码！！

## 代码

### 栈方法

28ms

```C++
class Solution {
public:
    int longestValidParentheses(string s) {
        int len = s.size();
        stack<int> idxStack;
        for(int i = 0; i < len; ++i)
        {
            if(s[i] == '('){ idxStack.push(i); }
            else
            {
                if(!idxStack.empty() && s[idxStack.top()] == '(')
                {
                    // match
                    idxStack.pop();
                }
                else{ idxStack.push(i); }
            }
        }
        if(idxStack.empty()){ return len; } // whole matched
        else
        {
            int endPos = len,
                maxLen = 0;
            while(!idxStack.empty())
            {
                maxLen = max(endPos - idxStack.top() - 1, maxLen);
                endPos = idxStack.top();
                idxStack.pop();
            }
            maxLen = max(maxLen, endPos - (-1) - 1);
            return maxLen;
        }
        
    }
};
```

### 动态规划

10ms

```C++
class Solution {
public:
    int longestValidParentheses(string s) {
        int len = s.length();
        int maxLen = 0;
        vector<int> maxLenEndWithHere(len, 0);
        for(int i = 0; i < len; ++i)
        {
            if(s[i] == '(')
            {
                // the parentheses ending with '(' can't be valid
                maxLenEndWithHere[i] = 0; // duplicated. 
            }
            else
            {
                // if matched with previous char
                if(i < 1){ continue; }
                if(s[i-1] == '(')
                {
                    maxLenEndWithHere[i] = i >= 2 ? maxLenEndWithHere[i-2] + 2 : 2;
                }
                else// s[i-1] == ')'
                {
                    int previousMatchedLen = maxLenEndWithHere[i-1];
                    int correspondingPos = i - 1 - previousMatchedLen;
                    if(correspondingPos >= 0 && s[correspondingPos] == '(')
                    {
                        maxLenEndWithHere[i] = correspondingPos >= 1 ? 
                                               maxLenEndWithHere[correspondingPos - 1] + maxLenEndWithHere[i-1] + 2 :
                                               maxLenEndWithHere[i-1] + 2;
                    }
                    else{ maxLenEndWithHere[i] = 0; }
                }
                maxLen = max(maxLen, maxLenEndWithHere[i]);
            }
        }
        return maxLen;
        
    }
};
```

### 双向

8ms , 双向方法还有一种，稍有不同，效率更高（反向更短）： [Why people give conclusion that this cannot be done with O(1) space? my AC solution: O(n) run time, O(1) space](https://discuss.leetcode.com/topic/7376/why-people-give-conclusion-that-this-cannot-be-done-with-o-1-space-my-ac-solution-o-n-run-time-o-1-space)

```C++
class Solution {
public:
    int longestValidParentheses(string s) {
        int len = s.length();
        int maxLen = 0;
        // forward
        int startPos = 0;
        int unMatchedLeftCnt = 0;
        for(int i = 0; i < len; ++i)
        {
            if(s[i] == '('){ ++unMatchedLeftCnt; }
            else
            {
                --unMatchedLeftCnt;
                if(unMatchedLeftCnt == 0)
                { 
                    // calc at every valid sequence
                    int matchedLen = i - startPos + 1;
                    maxLen = max(matchedLen, maxLen);
                }
                else if(unMatchedLeftCnt < 0)
                {
                    // not matched
                    unMatchedLeftCnt = 0;
                    startPos = i + 1;
                }
            }
        }
        
        // backward
        int endPos = len - 1;
        int unMatchedRightCnt = 0;
        for(int i = len - 1; i >= 0; --i)
        {
            if(s[i] == ')'){ ++unMatchedRightCnt; }
            else
            {
                --unMatchedRightCnt;
                if(unMatchedRightCnt == 0)
                {
                    int matchedLen = endPos - i + 1;
                    maxLen = max(maxLen, matchedLen);   
                }
                else if(unMatchedRightCnt < 0)
                {
                    unMatchedRightCnt = 0;
                    endPos = i - 1;
                }
            }
        }
        
        return maxLen;
    }
};
```