# problem 8. String to Integer (atoi)

[题目链接](https://leetcode.com/problems/string-to-integer-atoi/)

## 方法

自己想了下可能的输入，然后看了剧透内容，少了跳过空白字符的部分，倒也不算差太多吧。

然后就是写啊，还算简单，逻辑写得比较复杂。

还是有个疑惑——如果判断越界啊！！ 

还是不推崇用更大的数据类型，于是还是只会 除以10看与上一次的数是不是相等。感觉这个方法效率太低了。

## 代码

```C++
class Solution {
public:
    int myAtoi(string str) {
        size_t sz = str.length(),
               pos = 0;
        while(pos < sz && isspace(str[pos]) ){ ++pos; }
        if(pos == sz){ return 0; }
        char firstChar = str[pos];
        bool isNegative;
        if(isdigit(firstChar) || firstChar == '+') { isNegative = false; }
        else if( firstChar == '-' ) { isNegative == true; }
        else { return 0; }
        if(firstChar == '+' || firstChar == '-') 
        { 
            ++pos; 
            if( pos == sz){ return 0; }
        }
        // skip 0
        while(pos < sz && str[pos] == '0') { ++pos; }
        if(!isdigit(str[pos])){ return 0; }
        int val = str[pos] - '0';
        ++pos;
        if(isNegative){ val = -val; }
        int sign = isNegative ? -1 : 1; 
        while(pos < sz)
        {
            char c = str[pos];
            if(!isdigit(c)){ return val; }
            int nextVal = val * 10 + sign * (c - '0');
            if(nextVal / 10 != val)
            {
                // overflow
                if(isNegative){ return numeric_limits<int>::lowest(); }
                else { return numeric_limits<int>::max(); }
            }
            else { val = nextVal; }
            ++pos;
        }
        return val;
    }
};
```