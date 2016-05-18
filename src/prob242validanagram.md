###problem 242. Valid Anagram

[link](https://leetcode.com/problems/valid-anagram/)

## 方法

简单的一道题。

不过可以通过排序来实现，这个还是超出预期的。

## 代码

```C++
class Solution {
public:
    bool isAnagram(string s, string t) {
        if(s.length() != t.length()) return false ;
        unordered_map<char , int> cnt_record ;
        for(char c : s) ++cnt_record[c] ;
        for(char c : t) --cnt_record[c] ;
        for(auto &pair : cnt_record)
        {
            if(pair.second != 0) return false ;
        }
        return true ;
    }
};
```

## 后记

如果`unordered_map`使用`char`作为key的类型（如上述贴的代码），时间是36ms；如果用`int`做key，那么时间是40ms.

这应该是对key的hash操作耗时不同导致的。对大的数据类型，hash必然会慢一些吧。
