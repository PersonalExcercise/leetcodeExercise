# problem 164. Maximum Gap

[link](https://leetcode.com/problems/maximum-gap/)

## 方法

一眼看过去完全不知道该怎么做。

看了题解觉得很高端的样子，再后来多看了下，发现本质其实就是一个线性时间排序的问题！

线性时间排序，有计数排序、桶排序、基数排序。

计数排序时间复杂度与最大值与最小值差值有关。桶排序可以分桶，如果能够把问题转化到只计算桶间间距，那么时间复杂度就能是与输入个数成线性的了。基数排序没有尝试。

这道题官方题解是使用桶排序，每个桶只记录落到这个桶的最大值与最小值。为了使相邻两个数的最大间隔只存在两个连续非空桶间（前一个数是前一个桶的最大值，后一个数是后一个桶的最小值），**必须保证桶的个数大于等于输入数据的个数**。

为何？利用类鸽巢原理，n个数，n个桶，要么每个桶中一个数，要么至少有一个桶为空（暂且这么瞎称呼，正规的鸽巢原理是n+1个数，n个桶，则必然有一个桶至少有2个数）。如果每个桶中一个数，则连续非空桶间的最大间隔就是连续两个数的最大间隔，成立。如果至少一个桶为空，那么必然有两个连续的数，他们之间的间隔至少跨越了一个桶（表示的间隔），而在一个桶内的数，他们的间隔必然不会大于一个桶表示的间隔。

问题就变得简单了。

然而还是遇到了坑——

设桶的个数为输入数据个数。当输入数据只有2个时，桶的个数为2；桶的间隔计算公式写的是：

```C++
interval = static_cast<int>( 
             ceil(
                  ( maxVal - minVal ) / float(nrBuckets - 1)
                 )    
            ) ;
```

按理说肯定没有错的... minVal 必然落在第一个桶，maxVal落在第二个桶 (` (maxVal - minVal) / interval == 1 ? `)，然而却错了。

遇到了这个Case： `[2,99999999]`，既然发现 `static_cast<int>( ceil((9999999-2)/float(2-1)) )` 值为`10^8`，不应该是`99999997`吗！！

浮点数就这么不准吗...

遇到这个坑后，当时解决办法是用了`精确ceil`.. 所以精确，就是先判断能够整除（模为0），如果能则直接整数除法，如果不能，则整数除法再加1，这样因为是整数除法，所以就ok了。

```C++
 int exactCeilDivide(int dividend, int divisor)
    {
        if(dividend % divisor == 0){ return dividend / divisor ;}
        else {  return dividend / divisor + 1;}
    }
```

后来，我把桶设为输入数据数+1,即使使用`ceil`函数也不会有问题了...

不过，或许不遇到这个坑，也不会注意到这个问题吧。

## 代码

```C++
class Solution {
public:
    int maximumGap(vector<int>& nums) {
        size_t nrNum = nums.size() ; 
        if(nrNum < 2) return 0 ;
        int minVal = *min_element(nums.cbegin(), nums.cend());
        int maxVal = *max_element(nums.cbegin(), nums.cend());
        if(minVal == maxVal) return 0; // edge condition
        
        int nrBuckets = nrNum + 1;
        int bucketRangeVal = static_cast<int>( ceil( (maxVal-minVal)/float(nrBuckets-1)  ) );
        vector<bucket> buckets(nrBuckets);
        // dispatch
        for(int num : nums)
        {
            int bucketIdx = ( num - minVal ) / bucketRangeVal ;
            buckets[bucketIdx].fill(num);
        }
        // find max grap (only exists in different bucket)
        int maxGap = 0;
        auto aheadIter = buckets.begin() ; // min val must in the first bucket
        while(true)
        {
            auto nextFilledIter = aheadIter + 1 ;
            while(nextFilledIter < buckets.end() && !nextFilledIter->isFilled)
            {
                ++nextFilledIter;
            }
            if(nextFilledIter >= buckets.end()) break;
            maxGap = max(maxGap, get_bucket_gap(*aheadIter, *nextFilledIter));
            aheadIter = nextFilledIter;
        }
        return maxGap;
    }
private :
    struct bucket
    {
        int minVal;
        int maxVal;
        bool isFilled;
        bucket() : isFilled(false){}
        void fill(int val)
        {
            if(!isFilled)
            {
                minVal = maxVal = val;
                isFilled = true;
            }
            else
            {
                minVal = min(minVal, val);
                maxVal = max(maxVal, val);
            }
        }
    };
    int get_bucket_gap(const bucket &ahead, const bucket &bebind)
    {
        return (bebind.minVal - ahead.maxVal);
    }
};
```
