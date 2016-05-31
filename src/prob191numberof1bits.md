###problem 191. Number of 1 Bits

[link](https://leetcode.com/problems/number-of-1-bits/)


## 方法

非常有背景的一道题。

讨论见[stack-overflow](http://stackoverflow.com/questions/109023/how-to-count-the-number-of-set-bits-in-a-32-bit-integer)

详细见[维基百科-汉明重量](https://zh.wikipedia.org/wiki/%E6%B1%89%E6%98%8E%E9%87%8D%E9%87%8F) or [Wikipedia-Hamming Weight](https://en.wikipedia.org/wiki/Hamming_weight)

总的来说，这是经典的“汉明距离(Hamming Weight)”问题，由于在密码学、编码理论、信息论中常用到计算数据位中1的个数，所以有的CPU(X86)是有单独的指令(`popcnt`)来做这个操作的，GCC下有函数`__builtin_popcount(unsigned int x)`， MSVC下有`__popcnt(unsigned int value)`(<intrin.h>),`__mm_popcnt_u64(unsigned __int64 a)`(<nmmintrin.h>)，在C++标准库下有`std::bitset`来实现。

抛开已有的实现，自己实现，又有神奇的"树状相加"位操作，这个看不懂记不住。

再往下，有 `while(n) {cnt += n & 1 ; n &= n-1 }` ，通过`n & n-1`每次消去n中的一个1。

再往下，就是能够通常相出来的每次右移（无符号）来确认1的个数。

这的确是一个很不简单的问题。

## 代码

```C++
class Solution {
public:
    int hammingWeight(uint32_t n) {
        int oneBitCnt = 0 ;
        while(n)
        {
            if( (n & 1) == 1 ) { ++ oneBitCnt ;}
            n = n >> 1 ;
        }
        return oneBitCnt ;
    }
};
```

## 后记

上述代码实现是算是最LOW的方法，时间消耗上与使用`__builtin_popcount(unsigned)`方法相同（leetcode平台），耗时8ms；使用标准库`std::bitset<32>(n).count()`耗时4ms。

最后，上述代码有改进空间，就是去掉if语句： ` oneBitCnt += n & 1`

理论上去掉`if`是更好的选择...我看维基百科中甚至有把循环展开写的... 

！ 结果更新，当我去掉if后，耗时变为4ms！当然，我不知道背后发生了什么... 不知道是if给流水带来的影响，还是编译器的优化. 

说起优化，想起之前看到的一句话——不懂原理的优化简直就是邪恶。所以，咱们暂时就这么写着，以后也不必刻意在乎if是否存在... 因为这种层次上优化，往往需要深厚的对编译的理解。此刻我还不懂，也暂时不必深究。