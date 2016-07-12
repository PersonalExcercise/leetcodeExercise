# problem 5. Longest Palindromic Substring

[题目链接](https://leetcode.com/problems/longest-palindromic-substring/)

## 方法

只能想到暴力与动态规划。看了题解有 中心扩展法，其中又有[Simple C++ solution (8ms, 13 lines)](https://discuss.leetcode.com/topic/12187/simple-c-solution-8ms-13-lines)通过先把相同字符串找到来跳过回文字符串奇、偶的问题。

本来以为很好了，想不到还有更加好的——Manacher's Algorithm,从article中看到的。然而现在还没有时间看啊。

另外，还可以把这个问题转换为最长公共子串的问题。不是子序列，是子串。先反转字符串，再找相等的即可。注意索引需要相对应！

完整的题解：[5. Longest Palindromic Substring](https://leetcode.com/articles/longest-palindromic-substring/#approach-1-longest-common-substring-accepted)

以后可以这样来找完整题解了：

google :

site:https://leetcode.com/articles [key-word]

这样应该能更加完整。

## 代码

```C++
class Solution {
public:
    string longestPalindrome(string s) {
        // learned from https://discuss.leetcode.com/topic/12187/simple-c-solution-8ms-13-lines
        int len = s.length();
        if(0 == len){ return s; }
        int centerPos = 0;
        int maxLen = 1,
            startPos = 0;
        while(centerPos < len)
        {
            if(len - centerPos < maxLen / 2){ break; } // never can longer
            int left = centerPos,
                right = centerPos;
            // find the same characters and extend
            while(right + 1 < len && s[right+1] == s[right]){ ++right; }
            centerPos = right + 1; // update center pos !
            while(left - 1 >= 0 && right + 1 < len && s[left-1] == s[right+1])
            {
                --left;
                ++right;
            }
            int newLen = right - left + 1;
            if(newLen > maxLen)
            {
                maxLen = newLen;
                startPos = left;
            }
            
        }
        return s.substr(startPos, maxLen);
    }
};
```