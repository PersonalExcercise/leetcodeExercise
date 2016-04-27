###problem 12. Integer to Roman

[link](https://leetcode.com/problems/integer-to-roman/)

## 方法

看到这个题完全不知道该怎么做。

查看维基百科更是被这个复杂的规则吓住了，这得考虑多少种情况啊...

然而幸好还查了其他的...

[How to convert number to roman numerals](http://www.rapidtables.com/convert/number/how-number-to-roman-numerals.htm) 写得实在太好了。

转抄一下:

1. 对数num，查下边的表，找到最大的那个数，且该数小于等于num 。 


    | Decimal value | Roman numeral (n) |
    |---------------|-------------------|
    |1              | I                 |
    |4              | IV                |
    |5              | V                 |
    |9              | IX                | 
    |10             | X                 | 
    |40             | XL                | 
    |50             | L                 | 
    |90             | XC                | 
    |100            | C                 | 
    |400            | CD                | 
    |500            | D                 |
    |900            | CM                | 
    |1000           | M                 | 
    
    大概有个规律，就是罗马数中的整数位(I,V,X,L,C,D)以及比该整数位少小一个等级整数的整数需要被查表转换。

2. 设该数为`t` ，将该数对应的罗马字符`附加`（右侧）到结果串中， 并且更新`num = num - t`

3. 重复1，直到num为0

## 代码

```C++
class Solution {
public:
    string intToRoman(int num) {
        string romanStr = "" ;
        while(num != 0)
        {
            int ite = TransTableSize - 1 ;
            while(num < TransTable[ite].first) --ite ;
            romanStr += TransTable[ite].second ;
            num -= TransTable[ite].first ;
        }
        return romanStr ;
    }
private :
    const int TransTableSize = 13 ;
    const vector<pair<int , string> > TransTable = { 
        {1 , "I"} ,  {4 , "IV"} , {5 , "V"} , {9 , "IX"} ,
        {10 , "X"} , {40 , "XL"} , {50 , "L"} , {90 , "XC"} ,
        {100 , "C"} , {400 , "CD"} , {500 , "D"} , {900 , "CM"} ,
        {1000 , "M"}
    } ;
};
```

## 后记

对标准库中的`array`失望了。本来想用`array`来存 TransTable的，然而在Array情况下，里面的{int , string}表示不能被解释为`pair` ，因为`array`允许在初始化时使用双括号，即该括号被认为是初始化array的，故报错的。

还是`vector`大法好。以后弃用array了。
