# problem 90. Subsets II

[题目链接](https://leetcode.com/problems/subsets-ii/)

## 方法

子集1的时候，没有重复的问题。那时候除了深搜，觉得用 sz个bit中的所有可能对应集合各元素是否取来构建结果集非常nice。

但是有重复后，似乎上述方法不是很work? 也看到题解中有用迭代方法做的，没有欲望再看了。

明白刷题是为了什么——通用方法。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> subsetsWithDup(vector<int>& nums) {
        vector<int> currentSet;
        vector<vector<int>> result;
        sort(nums.begin(), nums.end());
        buildSubsetRecursively(currentSet, result, nums);
        return result;
    }
private:
    void buildSubsetRecursively(vector<int> &currentSet, vector<vector<int>> &result, 
                                const vector<int> &nums, size_t startPos=0)
    {
        result.push_back(currentSet);
        if(startPos >= nums.size()){ return; }
        while(startPos < nums.size())
        {
            currentSet.push_back(nums[startPos]);
            buildSubsetRecursively(currentSet, result, nums, startPos+1);
            currentSet.pop_back();
            ++startPos;
            // skip
            while(startPos < nums.size() && nums[startPos] == nums[startPos-1]){ ++startPos; }
        }
    }
};
```