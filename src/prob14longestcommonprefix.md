# problem 14. Longest Common Prefix

[题目链接](https://leetcode.com/problems/longest-common-prefix/)

## 方法

写了个非常直观的代码。

看了下题解，觉得题解中使用二分、分治的思想非常的好。虽然最终看时间复杂度也一样，但是能够想到分治、二分总感觉很厉害啊。有这样一种思想总是很好的。

## 代码

```C++
class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        size_t nrStr = strs.size();
        if(nrStr == 0){ return ""; }
        int maxLen = 0;
        while(true)
        {
            if(maxLen >= strs[0].length()){ break; }
            char c = strs[0][maxLen];
            bool isValid = true;
            for(size_t i = 1; i < nrStr; ++i)
            {
                if(maxLen >= strs[i].length() || strs[i][maxLen] != c)
                {
                    isValid = false;
                    break;
                }
            }
            if(!isValid){ break; }
            ++maxLen;
        }
        return strs[0].substr(0,maxLen);
    }
};
```

## 后记

看了下DISCUSS，里面的代码比我这个写得简洁些；主要地一个不好的地方是，判断字符是否相等时，可以不存当前位置的字符，而用 `strs[i][pos] == str[i-1][pos]`来判断，这样就非常好了~