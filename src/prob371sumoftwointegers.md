# problem 371. Sum of Two Integers

[题目链接](https://leetcode.com/problems/sum-of-two-integers/)

## 方法

虽然我用的是位操作，然后其实逻辑上和字符串操作一样...从第0位看到31位，每次看数的特定位次，使用异或运算完成3个bit的加法，使用 每两个数取与操作最后取或来得到进位；

需要说明的是，经过测试，负数与正数、正数与正数、负数与负数都是一样的规则。这一切都要归功于计算机用补码来统一。

## 代码

```C++
class Solution {
public:
    int getSum(int a, int b) {
        int carry = 0;
        int result = 0;
        for(int i = 0; i < 32; ++i)
        {
            int maskedNum1 = mask(a, i);
            int maskedNum2 = mask(b, i);
            result |= maskedNum1 ^ maskedNum2 ^ carry;
            carry = (maskedNum1 & maskedNum2) | (maskedNum1 & carry) | (maskedNum2 & carry) ;
            carry <<= 1;
        }
        return result;
    }
private:
    int mask(int num, int bitNum)
    {
        return num & (1 << bitNum);
    }
};
```

## 后记

看了DICUSS，才发现自己写的有多烂...

[One liner with detailed explanation](https://leetcode.com/discuss/111784/one-liner-with-detailed-explanation)

位操作可以一次全部算完（batch），与每位上的操作一致，把异或的结果整体赋给a，将与的结果左移一位再赋给进位。然后——就再计算变化后的a与进位间的加法。可以递归，可以迭代。

迭代的代码人家是这么写的：

```C++
int getSum(int a, int b) {while (b=(~(a^=b)&b)<<1); return a;}
```

分成多行，

```C++
int getSum(int a, int b) {
    while ( b= (~(a^=b) &b ) <<1 ); 
    return a;
}
```

首先，a^=b还是将异或结果赋给a，然后~优先级高于&，故先取反，再与上b，这其实就是得到原来的a与上b的结果——`~(a ^ b) & b == a & b`

哎，clever，但不好读？ 主要是位操作不熟吧，算了半天才确定。

