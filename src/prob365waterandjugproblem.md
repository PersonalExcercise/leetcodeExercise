# problem 365. Water and Jug Problem

[题目链接](https://leetcode.com/problems/water-and-jug-problem/)

## 方法

服了，这个题不是太懂。以前考试的时候考过，是用深搜来做... 于是我就做了，然后发现内存爆了。有个case数太大。

然后看了DISCUSS，网上也看了下，发现是这样：

1. 问题等价为： `m x + n y = z`是否有关于m、n的整数解。

2. 上述问题即是[`裴蜀定理`](https://zh.wikipedia.org/wiki/%E8%B2%9D%E7%A5%96%E7%AD%89%E5%BC%8F), 即是说，只要z是x、y的最大公约数的倍数即可。

3. 最后，在装水问题下，又有限制——因为水桶容积优先，最大值就是 x + y 。

最后，求解[最大公约数的代码](https://zh.wikipedia.org/wiki/%E6%9C%80%E5%A4%A7%E5%85%AC%E5%9B%A0%E6%95%B8)：

```
int gcd(int x, int y)
{
    if(y){ while((x %= y) && (y%=x));}
    return x + y;
}
```

因为除数不能为0。



## 代码

```C++
class Solution {
public:
    bool canMeasureWater(int x, int y, int z) {
        if(x + y < z) { return false;}
        if(x + y == z) { return true; }
        return z % gcd(x,y) == 0 ;
    }
private:
    int gcd(int x, int y)
    {
        if(y){ while((x %= y) && (y%=x)); }
        return x + y;
    }
};
```

## 后记

还有个case， 0, 0, 0 —— 所以需要预先判断。

哎，真难...