# problem 350. Intersection of Two Arrays II

[题目链接](https://leetcode.com/problems/intersection-of-two-arrays-ii/)

## 方法

一种方法是用一个HashTable记录下一个数组中各元素出现的次数，然后再去依次读下一个数组；遇到一个在HashTable中的元素，且次数大于0，则放入到结果数组中，且减少HashTable中的次数。

另一种方法，就是排序两个数组，然后再用双指针匹配一下就好了。涉及到对齐问题，在CWS的评价中已经写过了，没有什么难度吧。


## 代码

```C++
class Solution {
public:
    vector<int> intersect(vector<int>& nums1, vector<int>& nums2) {
        vector<int> result;
        sort(nums1.begin(), nums1.end());
        sort(nums2.begin(), nums2.end());
        size_t pos1 = 0,
               pos2 = 0,
               sz1 = nums1.size(),
               sz2 = nums2.size();
        while(pos1 < sz1 && pos2 < sz2)
        {
            while(pos1 < sz1 && nums1[pos1] < nums2[pos2]){ ++pos1; }
            while(pos2 < sz2 && pos1 < sz1 && nums2[pos2] < nums1[pos1]){ ++pos2; }
            while(pos1 < sz1 && pos2 < sz2 && nums1[pos1] == nums2[pos2])
            {
                result.push_back(nums1[pos1]);
                ++pos1;
                ++pos2;
            }
            
        }
        return result;
    }
};
```