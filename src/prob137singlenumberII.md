# problem 137. Single Number II

[题目链接](https://leetcode.com/problems/single-number-ii/)

## 方法

类似问题的一个通用解法，见 [Detailed explanation and generalization of the bitwise operation method for single numbers](https://discuss.leetcode.com/topic/11877/detailed-explanation-and-generalization-of-the-bitwise-operation-method-for-single-numbers) .真是娓娓道来。

简洁地说，就是把这个问题转为用位运算来计数的问题——设有m个1比特数（0或1），记录其中1的个数。

我们可以通过异或操作来做。m个数，最多有m个1，故我们需要一个 k = upper(log m) 位bit的数来存储。设各比特位为　B1,B2,...,Bk .我们可以发现，如果遇到0，那么Bi 异或0都等于原值，不变。这很好。但是遇到1时，我们应该加1，这该如何做呢？这就一位一位做吧。对于B1， B1' = B1 XOR 1 可以改变其值，即1变为0，0变为1，这是符合预期的。那么B2呢？只有当B1（这里是未更新前的B1）为1时，遇到1，B1才应该变，故就是 B2' = B2 XOR ( B1 & 1 ) , 验证一下，这也符合预期。其实后续位都是如此，即 Bi' = Bi XOR ( B{i-1} & .. B1 & 1) . 由此我们就可以用位操作来记录1的个数了。

那么上述理论跟题目有何关系呢？我们可以这么想——同一个数出现K次，只考虑某一个bit，那么该位的1的计数，要么是0（该位为0），要么是K（该位是1）。如果，我们给计数取模，模上K，那么其计数就都变为0了。如此，其他出现K此的数，其计数都是0。所以，我们就可以根据该位最终1的计数值来确定`只出现一次的数`的该位的值——为0就是0，为1就是1。

接着，又多出了一个问题，如何取模？很简单,就是当该值等于阈值时，令其为0就好。比如模5，那么当计数变为5时，立即令其为0就完成了模运算。另外，需要保证其他值不能改变，所以我们就给他`与`上一个mask，该mask在其他值时都是1，当变为阈值时就是0。这样一样就很简单——设阈值为X，各位分别为X1，X2，...,Xm, 那么就是 : ~( S1 & S2 & ... & Sm), 其中若Xi等于1，则Si = Xi，若Xi=0，则Si = ~Xi. 其实就是保证阈值出现上，里面的数相与结果是1，其余数时与上是0。

最后，如果那个独特的数不止出现一次呢？比如出现2（但要求其余的数出现次数不是2的倍数）次？也很容易，反正最后各位上1的计数结果都是该数各位上1出现的次数。如果次数大于1，那么该位肯定是1，如果为0，那就该位是0。

OK，具体怎么做？一个整数时32位，我们需要记录32个bit位上1出现的次数。如果其他数都出现K次（阈值是K），那么我们就需要uppper(log K)个bit才能记录下来。于是，我们申请upper(log K)个整数就好了。如果第1个整数当作32个位上计数结果的第0位，第uppper(log k)个整数当作第upper(log k)-1位。mask做法不变，因为位运算各位间彼此独立，所以32位互补影响。最后，如果出现K次，我们怎么得到该数？最直观的想法是返回这upper(log K)个数的`与`就好了。但其实更一般的——（先举个特别的例子）假设出现3次，那么可知，如果该位为0，计数的结果为00，如果该位为1，计数结果为3，即二进制的11。所以只需返回第0或第1个对应的计数值就可以了，它（们）就表示了该值。——假设出现了P次，把P写成二进制的形式，返回其中bit位为1对应的计数整数就好。

上面也是瞎说一通啊，感觉还不如人家的英语说得清楚呢...

## 代码

```C++
class Solution {
public:
    int singleNumber(vector<int>& nums) {
        // learned from https://discuss.leetcode.com/topic/11877/detailed-explanation-and-generalization-of-the-bitwise-operation-method-for-single-numbers/3
        int bitZero = 0,
            bitOne = 0;
        int mask = 0;
        for(int num : nums)
        {
            bitOne ^= bitZero & num;
            bitZero ^= num;
            mask = ~(bitZero & bitOne);
            bitOne &= mask;
            bitZero &= mask;
        }
        return bitZero;
    }
};
```

