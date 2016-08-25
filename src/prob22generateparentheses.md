# problem 22. Generate Parentheses

[题目链接](https://leetcode.com/problems/generate-parentheses/)

## 方法

哈哈，自己想出来了~

最开始完全没有思路，在想用组合学的知识求有多少对——然而没有算出来！然后发现其个数满足递推关系（没有求公式）。于是再尝试用递归方法，发现直接从生成的角度递归去做，其实非常简单。

用L表示剩下的左括号数，用M表示左括号比右括号多的个数。

如果L等于0，那么就只能补右括号了。

如果M等于0，那么就只能加左括号。

有了上面两个限制，每次递归操作里，第一步检查L值，是0就直接补右括号（刚好是M个）；如果不是，就先加一个左括号，递归调用；递归回来再检查M值，如果大于0则加右括号。

非常清晰，跟人工生成一样的思路啊。

## 代码

```C++
class Solution {
public:
    vector<string> generateParenthesis(int n) {
        vector<string> result;
        string currentStr;
        generateParentheseRecursively(result, currentStr, n);
        return result;
    }
private:
    void generateParentheseRecursively(vector<string> &result, string &currentStr,
                                       int remainingNrLeftParenthese, int nrLeftParentheseMoreThanRight=0)
    {
        if(remainingNrLeftParenthese == 0)
        {
            // no more left parentheses, just add right parentheses ( number = nrLeftParentTheseMoreThanRight)
            result.push_back(currentStr + string(nrLeftParentheseMoreThanRight, ')'));
            return;
        }
        // insert left parentheses
        currentStr.push_back('(');
        generateParentheseRecursively(result, currentStr, remainingNrLeftParenthese - 1, nrLeftParentheseMoreThanRight + 1);
        currentStr.pop_back(); // restore the state
        // insert right parentheses
        if(nrLeftParentheseMoreThanRight > 0)
        {
            currentStr.push_back(')');
            generateParentheseRecursively(result, currentStr, remainingNrLeftParenthese, nrLeftParentheseMoreThanRight - 1);
            currentStr.pop_back(); // restore the state
        }
    }
};
```