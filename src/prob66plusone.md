# problem 66. Plus One

[题目链接](https://leetcode.com/problems/plus-one/)

## 方法

一上来没有理解什么意思，以为挨个加1。

测了几个数，发现原来把vector中的数字整体作为一个数的表示，最后一个数字表示数字的最低位，0位置的数字表示最高位。

于是我就用普通加法+carry的方法做了一遍，还特别考虑了各位数字不合法的大的情况（大于9）。

最后不管怎样，都有可能给vector在位置0做一个insert，这个代价还是很大的。

结果看了题解[Is it a simple code(C++)?](https://leetcode.com/discuss/14616/is-it-a-simple-code-c)，简直惊为天人，叹为观止，五体投地：

```C++
void plusone(vector<int> &digits)
{
    int n = digits.size();
    for (int i = n - 1; i >= 0; --i)
    {
        if (digits[i] == 9)
        {
            digits[i] = 0;
        }
        else
        {
            digits[i]++;
            return;
        }
    }
    digits[0] =1;
    digits.push_back(0);
}
```

下面一个高级版：

```C++
vector<int> plusOne(vector<int>& digits) {
    for (int i=digits.size(); i--; digits[i] = 0)
        if (digits[i]++ < 9)
            return digits;
    digits[0]++;
    digits.push_back(0);
    return digits;
}
```

是在太帅了。真是不服不行。

## 代码

```C++
class Solution {
public:
    vector<int> plusOne(vector<int>& digits) {
        vector<int> result(digits);
        for(int i = result.size()-1; i >= 0; --i)
        {
            if(result[i] == 9){ result[i] = 0; }
            else
            { 
                ++result[i];
                return result;;
            }
        }
        result.push_back(0);
        result[0] = 1;
        return result;
    }
};
```