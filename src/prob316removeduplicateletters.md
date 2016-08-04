# problem 316. Remove Duplicate Letters

[题目链接](https://leetcode.com/problems/remove-duplicate-letters/)

## 方法

通过分析case找到了能够使结果传最小的方法，但是不够细致： 如果当前字符只出现了一次，那么必然应该在结果中。如果大于一次，再判断：如果当前字符比下一个字符大，且当前字符还会在后面出现，那么这个字符就该删去；如果比下个字符小，也并不能说明这个就该保留，应该往后找，直到遇到一个更小的字符、或者遇到一个字符，其只出现了一次。

上述的分析没有考虑等于的情况，事实上最后错了很多次，都是因为等于的情况没有弄正确。修修补补大半天，最后终于AC，然后却发现逻辑还是不是很清晰。一句话，白做了。

看了题解中的栈方法，觉得非常好。这才是可接受的算法的解法。

维护一个栈；对当前遇到的字符，

首先减去count。

然后判断这个字符是否已经在栈中了，如果是，则跳过；

接着重复做如下操作，来移除所有应该被移除的栈顶字母：当栈不空、且当前字符比栈顶字符小、且栈顶字符count>0(后面还会出现)。每从栈中移除一个字符，将是否在栈中的标志置为假。

移除操作完成后，将当前字符压入栈中，并置是否在栈中标志位真。

最后，得到的栈中元素就是最后满足要求的结果了。

## 代码

```C++

基本就是copy [C++ simple solution easy understanding](https://discuss.leetcode.com/topic/32172/c-simple-solution-easy-understanding)

class Solution {
public:
    string removeDuplicateLetters(string s) {
        vector<int> leftCnt(26, 0);
        vector<bool> isInResult(26, false);
        for(const auto &c : s){ ++leftCnt[c - 'a']; }
        string result = "";
        for(const auto &c : s)
        {
            --leftCnt[c-'a'];
            if(isInResult[c-'a']){ continue; }
            while(!result.empty() && c < result.back() && leftCnt[result.back() - 'a'] > 0)
            {
                isInResult[result.back()-'a'] = false;
                result.pop_back();
            }
            result.push_back(c);
            isInResult[c-'a'] = true;
        }
        return result;
    }
};

```

## 后记

用字符做索引时总是忘记 `-'a'`, 真是要命。