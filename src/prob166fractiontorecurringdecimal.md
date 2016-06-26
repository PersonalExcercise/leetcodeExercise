# problem 166. Fraction to Recurring Decimal

[题目链接](https://leetcode.com/problems/fraction-to-recurring-decimal/)

## 方法

只说方法：

其实很简单，就是把自己手算除法的过程用代码写一遍就好了。我分别处理了结果的整数部分和小数部分。一个是简单一些，另一个是方便处理循环小数。

循环小数的处理上，只要发现当前运算的除数是之前出现过的，那么其就进入到了循环。所以用一个hashTable，记录每个除数对应的结果位置。这样发现有循环出现时，能立即定位到循环的部分。


## 代码

```C++
class Solution {
public:
    string fractionToDecimal(int numerator, int denominator) {
        if(numerator == 0){ return "0"; }
        else if(denominator == 0)
        { 
            return numerator > 0 ? "inf" : "-inf" ; 
        }
        bool isPositive = (numerator > 0) == (denominator > 0) ;
        unsigned long long numeratorUL = abs(numerator + 0LL); // may be INT_MIN , so we should lift it to long long by add `0LL`
        unsigned long long denominatorUL = abs(denominator + 0LL);
        stack<unsigned> numeratorDigits;
        while(numeratorUL)
        {
            numeratorDigits.push(numeratorUL % 10);
            numeratorUL /= 10;
        }
        
        // Integer Part
        string integerPart = "";
        while(!numeratorDigits.empty())
        {
            numeratorUL = numeratorUL * 10 + numeratorDigits.top() ;
            numeratorDigits.pop();
            integerPart += to_string(numeratorUL / denominatorUL) ;
            numeratorUL %= denominatorUL;
        }
        // integerPart may have may leading 0 , like 00 when 40 / 333
        size_t notZeroFirstPos = integerPart.find_first_not_of("0");
        if(notZeroFirstPos == string::npos)
        {
            // not other digits but 0
            integerPart = "0"; 
        }
        else
        {
            integerPart = integerPart.substr(notZeroFirstPos);
        }
        // Decimal Part
        unordered_map<unsigned,size_t> num2pos;
        string decimalPart = "";
        while(numeratorUL)
        {
            if(num2pos.count(numeratorUL))
            {
                size_t startPos = num2pos[numeratorUL];
                decimalPart.insert(startPos, "(");
                decimalPart += ')';
                break;
            }
            else
            {
                num2pos[numeratorUL] = decimalPart.length();
            }
            numeratorUL *= 10 ;
            decimalPart += to_string(numeratorUL / denominatorUL);
            numeratorUL %= denominatorUL;
        }
        string result = integerPart ;
        if(decimalPart != ""){ result += "." + decimalPart; }
        if(isPositive){ return result ;}
        else { return "-" + result; }
    }
};
```

## 后记

此中的坑果然有些多，当然全部都是自己考虑不全。

1. 整数部分可能有多个leading 0 . 比如 40 / 333 , 要么做后处理，要么在除法时直接判断。当然可以偷懒直接用整数除法求整数部分就好了。

2. 小数部分为0； 就是能够整除，就不该有小数点了。这里不应该出错的，考虑太不周。

3. 最小负数的绝对值无法表示！

    ```
    If the result cannot be represented by the returned type (such as abs(INT_MIN) in an implementation with two's complement signed values), it causes undefined behavior.
    ```

    这个case真是牛逼！需要先提升成long long吧。