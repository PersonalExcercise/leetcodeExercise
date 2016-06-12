# problem 60. Permutation Sequence

[题目链接](https://leetcode.com/problems/permutation-sequence/)


## 方法

首先，第一眼看过去，没看出来规律。

看第二眼，找到了规律： 第高位往低位看，整个随机序列的最高位从1到n的，看某一确定高位下的序列，会发现次高位也是由低到高，只不过不断跳过之前位上已经出现过的单词。从递归的角度来说，这个n位排序随机序列的产生过程如下：

```Python

NUM_SEQ = {}
NUM_LEN = k
def GENERATE(num_prefix):
    for i = 1 -> n :
        if i in num_prefix : continue
        new_num_prefix = num_prefix + [ i ]
        if len(new_num_prefix) == NUM_LEN : 
            NUM_SEQ.append(new_num_prefix)
            continue
        else :
            GENERATE(new_num_prefix)
```
(万万没想到写伪代码竟然写成了Python...)

OK，上面顺序生成序列的过程就算是弄明白了。但是题目是找第k的随机数，可不是要求全部的数。当然不能用枚举的方法来做了，绝对会TLE的吧（9!的也太大了）。

所以我们的问题就变成了，已经知道了上面的生成规则，可不可以直接有第k个数来反推出各位的值呢？

画了一个4!的式子： `4! = 4 x 3 x 2 x 1`, 突然有了想法——将k不断除以和取模1,2,3,4，得到的值是否就是各位上的值（这里的值是相对1的偏移值，还得除去前面已经出现过的数）呢？

随机算了个简单的，恰恰如此！

（列一下吧...）

比如第7个数，首先要把7减去1（作为从0开始计数——为什么会这样，因为第一个数各位必然是0啊，如果不减肯定就不对了）。

那么就是说val = 6

1. 6 / 1 = 6 , 6 % 1 = 0 -> 第1位是0 （偏移0）

2. 6 / 2 = 3 , 6 % 2 = 0 -> 第2为是0

3. 3 / 3 = 1 , 3 % 3 = 0 -> 第3为是0

4. 1 / 4 = 0 , 1 % 4 = 1 -> 第4位是1

ok，最后val的值为0了，就停止。

然后倒过去看（因为是先生成高位），4位数

1. 第4位是1，表示相对于1偏移1，那么就是2

2. 第3位是0，表示相对于1的偏移是0，此时1也没有出现，故就是1

3. 第2位是0，表示相对于1的偏移是0，但此时1、2都出现了，故只能选3

4. 第1位是0，表示相对于1的偏移是0，这是只剩下4

故4位数的随机序列中，第7个就是 2134 .

其实最低位（上述‘第1位’）偏移肯定都是0（从直觉上理解，因为最后一位只有一种选择，从上面的算式理解，正整数模1都是0），所以可以跳过计算，当然不跳过也没什么影响。

上面在想的过程中，其实越来越清晰了——

**这不就是类似于十进制转二进制的思想吗**！！

然后我们再类别一下，这的确可以认为是一个**进制转换问题**。n位排列数，其每位的权从高往低，就是(n-1)!,(n-2)!,...,1 （更直观的说，每位的可选数值个数分别是n,n-1,n-2,...,1）.类比一下2进制，每位权值就是 2^(n-1),2^(n-2), ..., 2^0 （每位的可选数值只有两个）. 所以，相对于二进制，这是一个动态进制的数！此外，比二进制转换多一步就是，后面的数与前面是不重复的，所以还有一个选择数字的过程。

转换为进制转换的问题，上述的计算方式就更加可以理解了。这个问题也变得更加有清晰。

## 代码

```C++
class Solution {
public:
    string getPermutation(int n, int k) {
        assert(k > 0);
        string result(n,'1'); 
        vector<int> offsets(n,0);
        vector<bool> hasAppeared(n,false);
        calcOffset(n, k, offsets);
        // generate k-th number
        for(int bitPos = n-1 ; bitPos >= 0 ; --bitPos)
        {
            for(int candidateVal = 1 ; candidateVal <= n; ++candidateVal)
            {
                if(hasAppeared[candidateVal-1]){ continue ;}
                if( 0 == offsets[bitPos] ) 
                {
                    result[n-1-bitPos] = candidateVal - 1 + '1' ;
                    hasAppeared[candidateVal-1] = true;
                    break;
                }
                else{ --offsets[bitPos]; }
            }
        }
        return result;
    }
private:
    void calcOffset(int bitNum, int order, vector<int> &offsets)
    {
        --order ; // let it count from 0 instead of 1
        size_t bitPos = 0 ;
        while(bitPos < bitNum && order != 0) // in fact , if order is valid , there is no need for condition `bitPos < bitNum`
        {
            int curPosWeight = bitPos + 1;
            offsets[bitPos] = order % curPosWeight ;
            order /= curPosWeight;
            ++bitPos;
        }
    }
};
```