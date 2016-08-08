# problem 125. Valid Palindrome

[题目链接](https://leetcode.com/problems/valid-palindrome/)

## 方法

开始本来想先把非`alphanumeric`字符给去了，后来想直接双指针跳过就好了。

没有什么问题。

## 代码

```C++
class Solution {
public:
    bool isPalindrome(string s) {
        int forwardPtr = 0,
            backwardPtr = s.size() - 1;
        while(forwardPtr < backwardPtr)
        {
            // align
            while(forwardPtr <= backwardPtr && ! isalnum(s[forwardPtr])){ ++forwardPtr; }
            while(forwardPtr <= backwardPtr && ! isalnum(s[backwardPtr])){ --backwardPtr; }
            if(forwardPtr < backwardPtr)
            {
                if(toupper(s[forwardPtr]) == toupper(s[backwardPtr]))
                {
                    ++forwardPtr;
                    --backwardPtr;
                }
                else{ return false; }
            } // else break
        }
        return true;
    }
};
```

## 后记

学习了三个函数：

`isalnum` - 是否是alphanumeric , 即数字、小写字母、大写字母, 函数原型 `int isalnum(int ch)`, from `cctype`

`toupper`, `tolower` , 函数原型`int touppper(int ch)`, 与`local`有关，默认是ASCII中的小写转大写。是C系函数，有C++版，作为ctype的成员函数——不是很清楚用法。