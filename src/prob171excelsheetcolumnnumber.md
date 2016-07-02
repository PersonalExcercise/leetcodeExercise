# problem 171. Excel Sheet Column Number

[题目链接](https://leetcode.com/problems/excel-sheet-column-number/)

## 方法

做得有点稀里糊涂啊... 写完代码后，测了一个样例，然后+1的地方改了下，就过了...

## 代码

```C++
class Solution {
public:
    int titleToNumber(string s) {
        int len = s.length();
        int weight = 1;
        int result = 0;
        for(int i = len-1; i >= 0; --i)
        {
            unsigned char bitNum = s[i] - 'A' + 1;
            result += bitNum * weight;
            weight *= 26;
        }
        return result ;
    }
};
```


