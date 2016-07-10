# problem 219. Contains Duplicate II

[题目链接](https://leetcode.com/problems/contains-duplicate-ii/)

## 方法

在给定距离内是否有重复数字——把set改成记录最大位置的map就好了...

看了下DISCUSS，最多的投票还是用的set——只保留最近K个值的set。这样就非常省空间了。想想这样做的确很好啊！保留K个值也很简单。当迭代的序号大于K个，每次都把K范围前的一个元素移除就好了。这里还是非常巧妙的。

## 代码

```C++
class Solution {
public:
    bool containsNearbyDuplicate(vector<int>& nums, int k) {
        unordered_map<int, int> numPos;
        for(int i = 0; i < nums.size(); ++i)
        {
            int num = nums[i];
            if(numPos.count(num) > 0 && i - numPos[num] <= k ){ return true; }
            else { numPos[num] = i; }
        }
        return false;
    }
};
```