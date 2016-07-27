# problem 58. Length of Last Word

[题目链接](https://leetcode.com/problems/length-of-last-word/)


## 方法

大水题...

## 代码

```C++
class Solution {
public:
    int lengthOfLastWord(string s) {
        int lastPos = s.length() - 1;
        while(lastPos >= 0 && s[lastPos] == ' '){ --lastPos; }
        if(lastPos == -1){ return 0; }
        int startPos = lastPos - 1;
        while(startPos >= 0 && s[startPos] != ' '){ --startPos; }
        return lastPos - startPos;
    }
};
```