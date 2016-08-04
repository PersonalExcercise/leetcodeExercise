# problem 204. Count Primes

[题目链接](https://leetcode.com/problems/count-primes/)

## 方法

提示里把代码都给出来了... 

埃拉托斯特尼筛法，简称埃式筛。

具体方法是，建立从从2到n的素数表，初始全为true。

1. 从2开始，如果当前表值为真，则为素数；

2. 从这个素数开始筛去合数： 范围是 [ p*p, p*(p+1), p*(p+2), ... ], 其中p是当前的素数。

3. 开始测试下一个数。

算法复杂度是 O(n log log n), 几乎线性。

上述来源[维基百科-埃拉托斯特尼筛法](https://zh.wikipedia.org/wiki/%E5%9F%83%E6%8B%89%E6%89%98%E6%96%AF%E7%89%B9%E5%B0%BC%E7%AD%9B%E6%B3%95)

另，上述筛法有冗余，应该还有更加线性的方法，见[一般筛法求素数+快速线性筛法求素数](http://blog.csdn.net/dinosoft/article/details/5829550)，已经忘了具体怎么做的了。

记忆有限，只记最应该被记住的吧。

## 代码

```C++
class Solution {
public:
    int countPrimes(int n) {
        if(n <= 1){ return 0; }
        int primeCnt = 0;
        vector<bool> primeTable(n, true);
        int testLimit = sqrt(n) + 1;
        for(int i = 2; i < n; ++i)
        {
            if(primeTable[i] == true){ ++primeCnt; }
            // set composite number
            if(i > testLimit){ continue; }
            for(int k = i * i; k < n; k += i)
            {
                primeTable[k] = false;
            }
        }
        return primeCnt;
    }
};
```

## 后记

注意 越界问题—— 如果没有 

```C++
if(i > testLimit){ continue; }
```
而直接是下面的循环，那么 i * i 可能越界，因而运行时错误或者结果错误！一定要考虑越界问题！