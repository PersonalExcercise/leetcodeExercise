# problem 168. Excel Sheet Column Title

[题目链接](https://leetcode.com/problems/excel-sheet-column-title/)


## 方法

一个进制转换题。需要注意的是数是从1开始计数的！需要首先减掉1才行。

## 代码

```C++
class Solution {
public:
    string convertToTitle(int n) {
        string result;
        while(n > 0)
        {
            --n;
            result += n % 26 + 'A';
            n /= 26;
        }
        reverse(result.begin(), result.end());
        return result;
    }
};
```
