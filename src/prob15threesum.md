# problem 15. 3Sum

[题目链接](https://leetcode.com/problems/3sum/)

## 方法

首先想到了[combinationsum](prob39combinationsum.md), 这样做会有重复，因为给的数组中有重复数。于是又做了一个set来去重，结果——果然TLE了。

默默看了DISCUSS， [Concise O(N^2) Java solution](https://leetcode.com/discuss/23638/concise-o-n-2-java-solution) 写得太好了。原来是使用2个数的和等于某个值的方法，该方法先升序排序数组，再用一个指针指向头部，一个指针指向尾部，如果小于目标值，则要变大，头部指针往后移；如果大于目标值，则需要变小，尾部指针往前移。如果相等，则放入结果序列中，首尾指针一起相向移动。

现在是三个数，只需先确定一个数，再确定另外两个数即可。不允许重复，故只要第二个数指针在第一个数后面，第三个数再第二数指针后面即可，同时因为数组中数字本身有重复，所以需要跳过重复的值。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        vector<vector<int>> result;
        int firstNumPos = 0;
        int sz = nums.size();
        while(firstNumPos < sz - 2)
        {
            int secondNumPos = firstNumPos + 1,
                thirdNumPos = sz - 1;
            int targetSum = 0 - nums[firstNumPos];
            while(secondNumPos < thirdNumPos)
            {
                int sumVal = nums[secondNumPos] + nums[thirdNumPos];
                if(sumVal == targetSum)
                {
                    result.push_back({nums[firstNumPos], nums[secondNumPos], 
                                      nums[thirdNumPos]});
                    ++secondNumPos;
                    --thirdNumPos;
                    // skip same value
                    while(secondNumPos < thirdNumPos && nums[secondNumPos] == nums[secondNumPos-1])
                    {
                        ++secondNumPos;
                    }
                    while(secondNumPos < thirdNumPos && nums[thirdNumPos] == nums[thirdNumPos+1])
                    {
                        --thirdNumPos;
                    }
                }
                else if(sumVal < targetSum){ ++secondNumPos; }
                else { --thirdNumPos; }
            }
            // skip sampe value
            ++firstNumPos;
            while(firstNumPos < sz - 2 && nums[firstNumPos] == nums[firstNumPos-1])
            {
                ++firstNumPos;
            }
        }
        return result;
    }
};
```