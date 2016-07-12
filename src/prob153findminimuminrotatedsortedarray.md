# problem 153. Find Minimum in Rotated Sorted Array

[题目链接](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)


## 方法

分析起来比较简单，但是写起来又感觉戚戚然。

凡事遇到二分查找类似的题就觉得心慌。

以后除非遇到完完全全的二分，否则一定非常非常保守——不跳过=条件，不跳过可能的值。

## 代码

```C++
class Solution {
public:
    int findMin(vector<int>& nums) {
        unsigned sz = nums.size();
        if(sz == 0) { return 0;}
        int beg = 0 , 
            end = sz - 1 ;
        while(beg < end)
        {
            if(nums[beg] < nums[end]) // not rotated
            {
                return nums[beg];
            }
            int mid = beg + (end - beg)/2 ;
            if( nums[beg] <= nums[mid] ) // equal when beg == mid , here end = beg + 1
            {
                beg = mid + 1; // mid can't be the minimum 
            }
            else { end = mid ; } // mid may be minimum 
        }
        return nums[beg];
    }
};
```