# problem 349. Intersection of Two Arrays

[题目链接](https://leetcode.com/problems/intersection-of-two-arrays/)

## 方法

方法还是很简单；比较容易想到的就是

1. HashTable

2. 排序，双指针

但是标签里的二分搜索让我有些吃惊啊。我想还是没有必要的吧。除非我理解错了，不是用二分去找一个数是否存在。

代码写得很有问题，见后记。

## 代码

用STL的unordered_set没有意义，再次写了双指针。

```C++
class Solution {
public:
    vector<int> intersection(vector<int>& nums1, vector<int>& nums2) {
        size_t len1 = nums1.size() ,
               len2 = nums2.size();
        sort(nums1.begin(), nums1.end());
        sort(nums2.begin(), nums2.end());
        size_t pos1 = 0, 
               pos2 = 0;
        vector<int> result;
        while(pos1 < len1 && pos2 < len2)
        {
            while(pos1 < len1 && nums1[pos1] < nums2[pos2]){ ++pos1; }
            while(pos2 < len2 && pos1 < len1 && nums2[pos2] < nums1[pos1]){ ++pos2; }
            if(pos1 < len1 && pos2 < len2 && nums1[pos1] == nums2[pos2])
            { 
                result.push_back(nums1[pos1]); 
                ++pos1;
                while(pos1 < len1 && nums1[pos1-1] == nums1[pos1]){ ++pos1; }
                ++pos2;
                while(pos2 < len2 && nums2[pos2-1] == nums2[pos2]){ ++pos2; }
            }
        }
        return result;
    }
};
```

## 后记

不想错了两次！！都是错在跳过重复元素这里。

第一次，在第一个循环的最后这么写的：

```C++
while(pos1 < len1 && pos2 < len2 && nums1[pos1] == nums2[pos2]){ ++pos1; ++pos2; }
```
过不了Case ： [1,2] , [2,1] . 因为上述将会跳过2！逻辑错误了。不应该是当nums1和nums2对应元素相等则跳过，而应该是各自数组内部，元素相等跳过。

然后就改为这样的代码：

```C++
            while(pos1 + 1 < len1 && nums1[pos1+1] == nums1[pos1]){ ++pos1; }
            while(pos2 + 1 < len2 && nums2[pos2+1] == nums2[pos2]){ ++pos2; }
```

不想这个Case错误： [1,1,2,2], [2,2] , 结果里是[2,2]! 为什么？因为 pos1 + 1 < len1 这个判断出了问题——最后一个元素即使与前面是重复的，也不能被跳过！因为我们是在当前位置看下一个位置是否相等，故下一个位置自然不能是在外部。因而，我们又漏掉了最后一个元素。

怎么改——很直接地办法是在上述while之后再加一个判断，看最后一个元素与前一个元素书否相等，相等则跳过。然而太ugly了。想了下，我们应该放入到内层循环中！即当两个位置元素相等后。我们必然要往后+一个位置。此时我们顺利的可以从当前位置忘前看！这样最后一个位置的元素也会被考虑进来，这样就少了一个额外的判断。放在内层循环效率也稍高，因为判断少了（这句话似乎不太成立）。