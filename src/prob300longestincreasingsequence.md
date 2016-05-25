###problem 300. Longest Increasing Subsequence

[link](https://leetcode.com/problems/longest-increasing-subsequence/)

## 方法

难难难...

`O(n lgn)`方法之前看维基百科英文版的简直完全不懂... 直到看了 [最长递增子序列 O(NlogN)算法  不指定](https://www.felix021.com/blog/read.php?1587) 才明白。

我们首先申请一个名为`lastValueOfLIS`的向量，该向量表示某一个长度的最长递增序列的最后一个元素值（所有可能中最小的值）大小；
比如，`lastValueOfLIS[0]` 就表示长度为1的最长递增序列最后一个元素的值，且该值是所有长度为1的递增序列的最后一个值中最小的！类比一下`increasing triplet subsequence` ， 这完全是一个道理啊！！最小的方便确定新加的数应该能够构成多长的递增序列。

就是因为有了上面的基础，所以我们可以在将num值在`lastValueOfLIS`上做查找，从左往右找到第一个大于num的元素；如果没有遮掩的元素，说明num比当前所有长度的递增子序列最后一个值都大，则显然该数是更长的一个递增子序列的末尾元素，所以应该将该值附加到`lastValueOfLIS`上；如果找到了这个元素，设该元素索引为`i`,说明在长度为`i+1`的递增子序列中，该值比之前的值要小，应该替换掉之前的值。

以上，就是LIS的`O(n lgn)`实现。与之前的[334-longest increasing triplet subsequence](prob334increasingtriplesubsequence.md)有异曲同工之妙。

除了以上的方法，还有动态规划的方法。

第一种是使用LCS的方法——首先，我们把原始数组做一个排序后的拷贝;然后，我们就可以将该排序后的拷贝与原始数组序列求LCS。这种转换方法挺巧妙的！因为排序后的自然是递增的，然后又求递增的与原始数组的公共子串，这不就是最长递增子序列吗...666

第二种非常直观了，就是记录到每个位置的最长递增序列的长度。不过时间复杂度也是`O(n^2)`的。

## 代码

```C++
class Solution {
public:
    int lengthOfLIS(vector<int>& nums) {
        vector<int> lastValueOfLIS ;
        size_t numLen = nums.size() ; 
        if(0 == numLen) return 0 ;
        lastValueOfLIS.push_back(nums.at(0)) ;
        for(size_t i = 1 ; i < numLen ; ++i)
        {
            int curNum = nums.at(i) ;
            size_t ISLen4CurNum = getISLen4NewNum(lastValueOfLIS , curNum) ; 
            if(ISLen4CurNum == lastValueOfLIS.size()) { lastValueOfLIS.push_back(curNum) ; } // new longger IS
            else lastValueOfLIS.at(ISLen4CurNum) = curNum ; // update the last value of the IS with length ISLen4CurNum
        }
        return lastValueOfLIS.size() ;
    }
private :
    size_t getISLen4NewNum(const vector<int> &lastValueOfLIS , int newNum)
    {
        int low = 0 ,
            high = lastValueOfLIS.size() - 1;
        while(low <= high)
        {
            int mid = low + (high - low) / 2 ;
            int midVal = lastValueOfLIS.at(mid) ;
            if(newNum > midVal){ low = mid + 1 ; }
            else if(newNum < midVal){ high = mid - 1; }
            else { return mid ;}
        }
        return low ;
    }
};
```

## 后记

代码中确定每个数能够构成的最长递增子序列长度时，用的是二分查找，这是时间效率提升的关键，不过写对似乎不是那么的直接。写之前在草稿纸上写了半天，举了很多例子，确定这样没有问题。这里用插入排序来确定位置应该是最简单直观的，这样就能更加直观的理解这个方法了。毕竟，二分查找只是优化，理解本质时，它是无关紧要的。


