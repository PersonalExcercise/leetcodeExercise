# problem 88. Merge Sorted Array

[题目链接](https://leetcode.com/problems/merge-sorted-array/)

## 方法

很简单的~ 当然一般咱们做的是合并放到第三方的位置。这里要直接放到第一个数组里——为了避免移动的开销，我们直接从后面合并。这样就没有什么问题了。很简单啦~

## 代码

```C++
class Solution {
public:
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        int mergeIdx = m + n - 1,
            ptr1 = m - 1,
            ptr2 = n - 1;
        while(ptr1 >= 0 && ptr2 >= 0)
        {
            if(nums1[ptr1] > nums2[ptr2]){ nums1[mergeIdx--] = nums1[ptr1--]; }
            else{ nums1[mergeIdx--] = nums2[ptr2--]; }
        }
        while(ptr2 >= 0){ nums1[mergeIdx--] = nums2[ptr2--]; }
    }
};
```