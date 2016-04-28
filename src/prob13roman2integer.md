###problem 13. Roman to Integer 

[link](https://leetcode.com/problems/roman-to-integer/)

## 方法

12题的逆向。十分耍赖地完全使用了unordered_map , 所以这个题就没有意义了。


## 代码

实现效率不高。

```C++
class Solution {
public:
    int romanToInt(string s) {
        size_t len = s.length() ;
        int idx = 0 ;
        int num = 0 ;
        while(idx < len)
        {
            if(idx + 1 < len && TransTable.find(s.substr(idx , 2)) != TransTable.end())
            {
                num += TransTable[s.substr(idx , 2)] ;
                idx += 2 ;
            }
            else
            {
                num += TransTable[s.substr(idx , 1)] ;
                ++idx ;
            }
        }
        return num ;
    }

private :
    unordered_map<string , int> TransTable = {
        {"I" , 1} , {"IV" , 4 } , {"V" , 5} , 
        {"IX" , 9} , {"X" , 10} , {"XL" , 40} ,
        {"L" , 50} , {"XC" , 90} , {"C" , 100} ,
        {"CD" , 400} , {"D" , 500} , {"CM" , 900} ,
        {"M" , 1000}
    } ;
};
```

## 问题

如果我把unordered_map 声明为const的，那么编译会报错。

似乎对const的map不能做in-class initialization . 有点不知道为什么...

啊，烦烦烦