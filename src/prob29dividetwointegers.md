# problem 29. Divide Two Integers

[题目链接](https://leetcode.com/problems/divide-two-integers/)

## 方法

没有思路，直接看得DISCUSS，写得太好了。

[Detailed Explained 8ms C++ solution](https://leetcode.com/discuss/38997/detailed-explained-8ms-c-solution)

首先，dividend是被除数，divisor是除数；

接着，除法表示被除数中有多少个除数，所以在不让使用乘法、模运算的情况下，我们使用位操作来以2倍的速度增大除数，直到再增大就要大于被除数了。那么此时我们能够直到除数增大了多少倍，那么就是其中包含多少个除数。其个数就是除法的结果。当然，此时还没有除尽，所以用当前被除数减去该增大的除数，并开始下次循环，直到被除数小于除数为止。

由于除数二倍形式增大，并通过减法、再重新增大来不断逼近最后的结果，其过程有些类似二分查找。

最后，溢出情况：

1. 除数为0

2. 被除数为INT_MIN , 而除数为-1， 其结果为 `INT_MAX + 1` , 超过了int的范围，故溢出。

## 代码

```C++
class Solution {
public:
    int divide(int dividend, int divisor) {
        if( divisor == 0
            || ( dividend == numeric_limits<int>::lowest() && divisor == -1 )
          )
        {
            return numeric_limits<int>::max();
        }
        bool isPositive = ( dividend > 0 ) == ( divisor > 0) ;
        unsigned dividendU = abs(static_cast<long long>(dividend));
        unsigned divisorU = abs(static_cast<long long>(divisor)); // just in case INT_MIN , and `unsigned` can store it safely
        
        int result = 0 ;
        while(dividendU >= divisorU)
        {
            int nrBitMoved = 0 ;
            unsigned movedDivisor = divisorU;
            while(dividendU >= movedDivisor && ! isOverflowAfterMove(movedDivisor))
            {
                movedDivisor <<= 1;
                ++nrBitMoved;
            }
            if(dividendU >= movedDivisor)
            {
                // movedDivisor will overflow
                dividendU -= movedDivisor;
                result += ( 1 << nrBitMoved );
            }
            else
            {
                // movedDivisor is bigger
                movedDivisor >>= 1;
                --nrBitMoved;
                dividendU -= movedDivisor;
                result += ( 1 << nrBitMoved );
            }
        }
        return isPositive ? result : -result;
    }
private :
    bool isOverflowAfterMove(unsigned num)
    {
        // if the highest bit is 1 , then after left move , it will overflow
        return ( (num >> (sizeof(num) * 8 - 1)) == 1 ) ;
    }
};
```

## 后记

首先，abs在C++11下有3个重载，分别对int, long , long long . 此外，还有`labs`, `llabs`.

然后，代码中我检测了增大的除数是否有可能溢出。加上后面的if判断，这可能导致了我的代码效率不高。这对于我的代码是必须的！因为如果一贯增大除数的确有可能溢出。但是，上面列出的DISCUSS中的代码没有使用溢出检测，其也是对的。因为，他使用的是long long ! 由于被除数的绝对值范围是在unsigned int 之中的，故在long long、且刚好能大于被除数的情况下，其不可能溢出。但是我的代码中使用的是unsigned，故可能溢出。