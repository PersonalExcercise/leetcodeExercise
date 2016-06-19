# problem 354. Russian Doll Envelopes

[题目链接](https://leetcode.com/problems/russian-doll-envelopes/)

## 方法

不知怎么，直觉使然，觉得应该使用排序+LIS。

然而仅仅是直觉却不能解决问题，有两个问题需要解决：

1. 排序策略

2. LIS策略

自己之前想的是排序先按w递增，再按h递增；LIS存储数组使用vector的vector，因为每个状态可能有多个值：

如下面的情况： [2,3] , [5,8], [6,4] , [6,7] , [7,8]

到处理[6,4]时，LIS数组是 [2,3], [5,8]

此时[6,4]虽然w比[5,8]大，但是h小，我们不能替换\[5,8\] (假设后面有[6,10]，替换后就错误了)，又不能抛弃(抛弃后最优解就被抛弃了)。所以就只能存储起来。这样复杂度就成了O(n^2).

不是很好的方法，或者说，想得不清楚。

看了DISCUSS [Java NLogN Solution with Explanation](https://leetcode.com/discuss/106946/java-nlogn-solution-with-explanation)， 找到了问题的答案。 巧妙！

1. 排序策略是，按w递增，**w想等时h递减**排序

2. LIS只求h的LIS

上面的逻辑全面地解决了该问题。为什么？首先，我们要找的序列，是一个w递增，h也递增的最长序列。我们按w递增排序保证了w都是递增的。

关键是w相等时h递减排序。DISCUSS也说了原因，因为对于 [6,4] , [6,7]这样的元素，如果按h递增，显然只求h的LIS就错了！因为虽然h递增了，但是w是相等的，套不进去。而当我们逆序时，其实解决的问题是： **在w相同时，我们避免了上述不正确地扩张LIS数组**。因为最大的已经放前面的，后面的就不可能去在w相同的情况下，扩展长度。这样一来，w相同的不会扩张，w递增的h则不受影响，所以完美地解决了问题——此时，我们只需看h，找到最长的h递增序列就好了。

再尝试解释一遍：这种情况下，找到的序列，h必然是递增的没有问题（因为是LIS），而且w必然也是递增的（因为首先已经按w递增排序，其次相同的w对应的h是递减的，所以不会有相同w对应的pair出现在结果中）。

太厉害！

## 代码

```C++
class Solution {
public:
    int maxEnvelopes(vector<pair<int, int>>& envelopes) {
        size_t nrEnvelopes = envelopes.size() ;
        if(0 == nrEnvelopes){ return 0 ;}
        
        // sort on ascending w and descend h when same w
        auto sortPred = [](const pair<int, int> &wh1, const pair<int, int> &wh2) -> bool
        {
           int w1 = wh1.first , w2 = wh2.first, 
               h1 = wh1.second, h2 = wh2.second;
            if(w1 < w2){ return true ;} // ascending on w
            else if(w1 == w2)
            {
                if(h1 < h2){ return false ;} // descend on h
                else { return true ;}
            }
            else { return false ; }
        } ;
        sort(envelopes.begin(), envelopes.end(), sortPred);
        
        // LIS on h
        vector<int> LISEndWithMinHeight(1, envelopes.at(0).second);
        for(size_t pos = 1 ; pos < nrEnvelopes; ++pos)
        {
            const pair<int, int> curEnvelope = envelopes.at(pos);
            int curHeight = curEnvelope.second;
            int LISPos = binarySearch(LISEndWithMinHeight, curHeight);
            if(LISPos == LISEndWithMinHeight.size()){ LISEndWithMinHeight.push_back(curHeight); }
            else
            {
                assert(LISPos < LISEndWithMinHeight.size());
                LISEndWithMinHeight.at(LISPos) = curHeight;
            }
        }
        return LISEndWithMinHeight.size();
    }
private :
    int binarySearch(const vector<int> &sortedArray, int target)
    {
        int sz = sortedArray.size() ;
        int low = 0 ,
            high = sz - 1;
        while(low <= high)
        {
            int mid = low + (high - low)/2 ;
            int midVal = sortedArray.at(mid);
            if(target > midVal){ low = mid + 1; }
            else if(target < midVal){ high = mid - 1 ;}
            else { return mid ;}
        }
        return low; // low = high + 1
    }
};
```