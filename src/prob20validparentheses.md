# problem 20. Valid Parentheses

[题目链接](https://leetcode.com/problems/valid-parentheses/)

## 方法

嗯，用栈就好了。注意的是，弹栈前需要考虑栈是不是已经空了。

## 代码

```C++
class Solution {
public:
    bool isValid(string s) {
        stack<char> leftCharStack;
        for(char c : s)
        {
            if(isLeftParenthese(c)){ leftCharStack.push(c); }
            else
            {
                if(leftCharStack.empty() || !isMatch(leftCharStack.top(), c)){ return false; }
                else{ leftCharStack.pop(); }
            }
        }
        return leftCharStack.size() == 0;
    }
private:
    bool isLeftParenthese(char c)
    {
        static unordered_set<char> leftParentheseSet({'(', '[', '{'});
        return leftParentheseSet.count(c) > 0; 
    }
    bool isMatch(char leftChar, char rightChar)
    {
        return (leftChar == '(' && rightChar == ')') ||
               (leftChar == '[' && rightChar == ']') ||
               (leftChar == '{' && rightChar == '}');
    }
};
```