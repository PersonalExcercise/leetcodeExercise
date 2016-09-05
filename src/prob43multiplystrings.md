# problem 43. Multiply Strings

[题目链接](https://leetcode.com/problems/multiply-strings/)

## 方法

嗯，很直观的做法。想想自己能力还是进步了，差不多5年前（还是4年前），刚学完C语言，我连字符串的加法都搞不定。现在很轻松地搞定了乘法。

记得在过程中保持反转就好了。最后再反转回来，可以很方便！

## 代码

```C++
class Solution {
public:
    string multiply(string num1, string num2) {
        string reverseResult;
        int len1 = num1.size(),
            len2 = num2.size();
        int nrZero = 0;
        for(int i = len2 - 1; i >= 0; --i)
        {
            int curBitVal = char2literalInt(num2[i]);
            int carry = 0;
            string curReverseBitResult(nrZero, '0');
            for(int j = len1 - 1; j >= 0; --j)
            {
                int bitMulVal = char2literalInt(num1[j]) * curBitVal + carry;
                int currentBitVal = bitMulVal % 10;
                carry = bitMulVal / 10;
                curReverseBitResult.push_back(int2literalChar(currentBitVal));
            }
            if(carry > 0){ curReverseBitResult.push_back(int2literalChar(carry)); }
            if(carry >= 10){ cout << "OMG" << endl; }
            sum2Result(reverseResult, curReverseBitResult);
            ++nrZero;
        }
        postProcessing(reverseResult);
        reverse(reverseResult.begin(), reverseResult.end());
        return reverseResult;
    }
private:
    int char2literalInt(char x)
    {
        return x - '0';
    }
    char int2literalChar(int x)
    {
        return x + '0';
    }
    void sum2Result(string & reverseResult, const string &curReverseBitResult)
    {
        size_t pos1 = 0,
               pos2 = 0;
        int carry = 0;
        while(pos1 < reverseResult.size() && pos2 < curReverseBitResult.size())
        {
            int curAddVal = char2literalInt(reverseResult[pos1]) + char2literalInt(curReverseBitResult[pos2]) + carry;
            int curBitVal = curAddVal % 10;
            carry = curAddVal / 10;
            reverseResult[pos1] = int2literalChar(curBitVal);
            ++pos1;
            ++pos2;
        }
        while(pos1 < reverseResult.size())
        {
            int curAddVal = char2literalInt(reverseResult[pos1]) + carry;
            int curBitVal = curAddVal % 10;
            carry = curAddVal / 10;
            reverseResult[pos1] = int2literalChar(curBitVal);
            ++pos1;
        }
        while(pos2 < curReverseBitResult.size())
        {
            int curAddVal = char2literalInt(curReverseBitResult[pos2]) + carry;
            int curBitVal = curAddVal % 10;
            carry = curAddVal / 10;
            reverseResult.push_back(int2literalChar(curBitVal)); // reverseResult is less than the curReverseBitResult
            ++pos2;
        }
        if(carry > 0)
        {
            reverseResult.push_back(int2literalChar(carry));
        }
    }
    void postProcessing(string &reverseResult)
    {
        // remove duplicate zeros of the head( tail in reverse string)
        while(reverseResult.size() > 1 && reverseResult.back() == '0'){ reverseResult.pop_back(); }
    }
};
```