# problem 67. Add Binary

[题目链接](https://leetcode.com/problems/add-binary/)


## 方法

为了方便，先完全反转了字符串，然后再用二进制的加法做的。跟之前的链表加法一样。

## 代码

```C++
class Solution {
public:
    string addBinary(string a, string b) {
        reverse(a.begin(), a.end());
        reverse(b.begin(), b.end());
        size_t aSz = a.length(),
               bSz = b.length();
        string result;
        int minSz = min(aSz, bSz);
        int carry = 0;
        for(int i = 0; i < minSz; ++i)
        {
            unsigned char aBit = a[i] - '0';
            unsigned char bBit = b[i] - '0';
            unsigned char bitResult = aBit ^ bBit ^ carry;
            carry = (aBit & bBit) | (aBit & carry) | (bBit & carry);
            result += '0' + bitResult;
        }
        for(int i = minSz; i < aSz; ++i)
        {
            unsigned char aBit = a[i] - '0';
            unsigned char bitResult = aBit ^ carry;
            carry = aBit & carry;
            result += '0' + bitResult;
        }
        for(int i = minSz; i < bSz; ++i)
        {
            unsigned char bBit = b[i] - '0';
            unsigned char bitResult = bBit ^ carry;
            carry = bBit & carry;
            result += '0' + bitResult;
        }
        if(carry){ result += '1'; }
        reverse(result.begin(), result.end());
        return result;
    }
};
```
## 后记

真是又丑又长的代码啊..

效率上，reverse说不上开销太大——最好不reverse a、b，但是结果最好reverse一下，这样存储时直接+=，这样效率是很高的。否则每次相加都要完全生成一个新的字符串。

最后，标准库的`reverse`方法，非常好用！标准库代码写得就是好啊：

```C++
template <class BidirectionalIterator>
  void reverse (BidirectionalIterator first, BidirectionalIterator last)
{
  while ((first!=last)&&(first!=--last)) {
    std::iter_swap (first,last);
    ++first;
  }
}
```