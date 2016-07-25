# problem 205. Isomorphic Strings

[题目链接](https://leetcode.com/problems/isomorphic-strings/)

## 方法

保证双射就好了。很简单的模式匹配。

我记得之前完全做过类似的题.. 但是忘了是那一道了

## 代码

```C++
class Solution {
public:
    bool isIsomorphic(string s, string t) {
        unsigned sz = s.size();
        if(sz != t.size()){ return false; }
        vector<char> s2tMap(128, -1),
                     t2sMap(128, -1);
        for(size_t i = 0; i < sz; ++i)
        {
            char &sc = s[i],
                 &tc = t[i];
            if(s2tMap[sc] == -1 && t2sMap[tc] == -1)
            {
                // no pattern suit for sc->tc & tc->sc
                s2tMap[sc] = tc;
                t2sMap[tc] = sc;
            }
            else if(s2tMap[sc] != tc || t2sMap[tc] != sc){ return false; }
        }
        return true;
    }
};
```