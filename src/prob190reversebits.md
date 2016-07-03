# problem 190. Reverse Bits

[题目链接](https://leetcode.com/problems/reverse-bits/)


## 方法

这个题肯定是可以做出来的，就是看够不够简洁了。

DISCUSS暂时关闭了，看不到优秀代码...

而且题目中有个后续问题： 如果这个函数被重复调用多次，你应该如何去优化它？

这里有个问题，就是重复调用是不是对同一个数？如果是，加上static的变量缓存结果？如果不是，似乎也没有什么好方法啊。

## 代码

```C++
class Solution {
public:
    uint32_t reverseBits(uint32_t n) {
        
        
        int low = 0, high = 31;
        while(low < high)
        {
            uint32_t lowBit = mask(n, low);
            uint32_t highBit = mask(n, high);
            // set high
            setBit(n, lowBit != 0, high);
            // set low
            setBit(n, highBit != 0, low);
            ++low;
            --high;
        }
        return n;
    }
private:
    uint32_t mask(uint32_t val, int maskPos)
    {
        return val & (1U << maskPos) ;
    }
    void setBit(uint32_t &val, bool isOne, int setPos)
    {
        if(isOne)
        {
            val |= (1U << setPos);
        }
        else
        {
            val &=  ~(1U << setPos);
        }
    }
};
```
