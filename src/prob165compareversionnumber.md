# problem 165. Compare Version Numbers

[题目链接](https://leetcode.com/problems/compare-version-numbers/)

## 方法

非常直观的想法。使用标准库的find而不是字符串的find函数，这是因为字符串的find函数在找不到元素时返回string::npos，即无穷大，需要额外的处理；但是标准库直接返回尾后元素，可以与处理程序完美的结合，不需要额外的判断，故写起来更加顺。

这道题难点应该是边界的处理，或者说对非规范版本号地处理：

如一想的两个case（分别错了一次...）

1. 01 与 1

2. 1.0 与 1

所以，一定不要做任何假设。除非题目非常明确，那么尽可能考虑所有的可能吧。

把程序写得鲁棒性而能处理各种错误输入，这是一种能力！能够考虑所有可能的输入，这同样是一种能力。

## 代码

```C++
class Solution {
public:
    int compareVersion(string version1, string version2) {
        string::const_iterator startIter1 = version1.cbegin(),
                               startIter2 = version2.cbegin(),
                               endIter1 = version1.cend(),
                               endIter2 = version2.cend();
        while(startIter1 < endIter1 && startIter2 < endIter2)
        {
            string::const_iterator dotIter1 = find(startIter1, endIter1, '.'),
                                   dotIter2 = find(startIter2, endIter2, '.');
            // skip start zero, such as 001, 01
            while(startIter1 < endIter1 && *startIter1 == '0'){ ++startIter1; }
            while(startIter2 < endIter2 && *startIter2 == '0'){ ++startIter2; }
            size_t rangeLen1 = dotIter1 - startIter1 ,
                   rangeLen2 = dotIter2 - startIter2;
            // for valid version number , longer should be bigger
            if(rangeLen1 < rangeLen2){ return -1; }
            else if(rangeLen1 > rangeLen2){ return 1; }
            for(size_t i = 0; i < rangeLen1; ++i)
            {
                if(*startIter1 < *startIter2){ return -1; }
                else if(*startIter1 > *startIter2){ return 1; }
                ++startIter1;
                ++startIter2;
            }
            startIter1 = ++dotIter1;
            startIter2 = ++dotIter2;
        }
        startIter1 = skipZerosEnd(startIter1, endIter1);
        startIter2 = skipZerosEnd(startIter2, endIter2);
        if(startIter2 < endIter2){ return -1; }
        else if(startIter1 < endIter1){ return 1; }
        else { return 0; }
    }
private:
    // skip zeros end , such as 1.00 , 1.0 , 1.0.0.0.0000
    string::const_iterator
    skipZerosEnd(string::const_iterator first, string::const_iterator last)
    {
        while(first < last && ( *first == '0' || *first == '.') ){ ++first; }
        return first;
    }
};
```
