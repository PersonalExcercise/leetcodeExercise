# problem 152. Maximum Product Subarray

[link](https://leetcode.com/problems/maximum-product-subarray/)

## 方法

嗯，一定注意相关的问题——[最大和的子数组](prob53maxsubarray.md) 。

此问题与最大和问题类似，也可以使用暴力、分治、动态规划的方法。不过动态规划方法相比最大和有所不同，因而直接循环求取就不能实施了(或者说可以实施，但是仍旧是用了动态规划的思想)。


二者不同之处在于，对于和，一个负数只能带来负面影响。然而对乘积来说，一个负数并不能说一定会使乘积变小——因为你不知道下个时刻是否还有负数。毕竟负负得正啊。

因而，一个很直接的思路就是，即保存最大的整数，又保存最小的负数。自己在这里犯了一点错误，最后意识到，其实只需保存最大的数和最小的数即可，不用刻意去保证正数与负数这一说。考虑的话可能会使问题复杂（开始考虑了，发现一团糟...）

设定动态规划递归关系式，我们用`MAX[i]`表示以`i`结尾的子数组乘积的最大值，用`MIN[i]`表示乘积的最小值，则递推为：

```C++
MAX[i] = max(Num[i] , Num[i] * MAX[i-1] , Num[i] * MIN[i-1]) ;

MIN[i] = min(Num[i] , Num[i] * MAX[i-1] , Num[i] * MIN[i-1])
```

初始时将`MAX[0]` ， `MIN[0]`均设为`Num[0]`即可。

以上就完成了动态规划的设计。

然后可以发现，其实没有必要开一个数组，因为动态规划过程只需要前一个状态，所以一个整数即可！这样我们可以只用两个数来表示前一个时刻的以上一个数结尾的子序列乘积的最大值和最小值。这样看起来我们可以直接用一个循环就完成了，就像最大子数组和那样。但是他们都是从动态规划推过去的...

## 代码

```C++
class Solution {
public:
    int maxProduct(vector<int>& nums) {
        size_t sz = nums.size() ;
        vector<int> maxNumEndingWithCurNum(sz) ;
        vector<int> minNumEndingWithCurNum(sz) ;
        int maxProdVal ;
        if(0 == sz) return 0 ;
        maxNumEndingWithCurNum[0] = minNumEndingWithCurNum[0] = nums[0] ;
        maxProdVal = maxNumEndingWithCurNum[0] ;
        for(int i = 1 ; i < sz ; ++i)
        {
            int curNum = nums[i] ;
            int candidateNum1 = curNum * maxNumEndingWithCurNum[i-1] ;
            int candidateNum2 = curNum * minNumEndingWithCurNum[i-1] ;
            int maxNum = max( curNum , max(candidateNum1, candidateNum2) ) ;
            int minNum = min( curNum , min(candidateNum1, candidateNum2) ) ;
            maxNumEndingWithCurNum[i] = maxNum ;
            minNumEndingWithCurNum[i] = minNum ;
            maxProdVal = max(maxProdVal , maxNum) ;
        }
        return maxProdVal ;
    }
};

```