###problem 35. Search Insert Position

[link](https://leetcode.com/problems/search-insert-position/)

## 方法

能够比较快的明确思路——就是二分查找的应用。

然而写起来还是很费劲，之前那道[找最长递增序列的长度](prob300longestincreasingsequence.md)其实就需要用到这道题的算法来实现快速查找插入位置（完全一样好吗！当时就写出来了啊...但是现在又忘了...）。 直接看了DISCUSS的代码.

记住了两点关键：

1. 循环条件是`low<=high`， 其中high初始为`size -1`，即没有与STL中的范围下标规范一致。（可以一致的，如果要一致，那么循环条件就是小于）

2. 循环跳出条件，必然满足`low == high+1`，所以返回`low`或者`high+1`都是没有问题的。但是mid的值是不确定的，在退出之前，mid值肯定是等于low的，但是退出后mid与low的关系就不一定了...(有可能是mid小1，有可能是相等)

## 代码

```C++
class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        int sz = nums.size() ;
        int low = 0 , 
            high = sz -1 ;
        while( low <= high )
        {
            int mid = low + (high - low)/2 ;
            int midVal = nums[mid];
            if(target < midVal){ high = mid -1 ; }
            else if(target > midVal){ low = mid + 1 ; }
            else return mid ;
        }
        // here `low == high + 1` is always right
        return low ;
    }
};
```


